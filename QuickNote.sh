#! /usr/bin/bash

#Add the path to the inbox file below
inbox_file="path/to/inbox/file"

#Choose dialog application
#dialog_application=zenity
dialog_application=kdialog

#Choose Zenity dialog type
zenity_multiline=yes

backup_folder="$HOME/backups/inbox_backups"
if [ -z "${inbox_file}" ]; then
  zenity --error --text="Please set the inbox file in the script first"
  exit 1
fi

if [ "$dialog_application" == "zenity" ]; then
  if [ "$zenity_multiline" == "yes" ];then
    if ! input=$(zenity --text-info --editable --title="Add Note" --text="'-' to start with a bullet point, 'esc' to close without saving"); then
      exit
    fi
  else
    if ! input=$(zenity --entry --title="Add Note" --text="'-' to start with a bullet point, 'esc' to close without saving, enter to submit"); then
      exit
    fi
  fi
elif [ "$dialog_application" == "kdialog" ]; then
  if ! input=$(kdialog --title 'Add Note' --textinputbox "'ctrl+enter' to submit, '-' to start with bullet point, and 'esc' to close without saving"); then
    exit
  fi
fi

if [ -z "${input}" ]; then
  echo "Note not saved, note is empty"
  notify-send "note not saved, note is empty"
  exit 0
fi

date="$(printf '%(%Y-%m-%d %H:%M:%S)T\n' -1)"
note="<!-- $date -->"$'\n'"$input"

printf "Input is %s\n" "$note"
echo -e "\n$note" >> "$inbox_file"
#cat "$inbox_file"
note_lines=$(echo -n "$note" | awk 'END {print NR}')
#echo "note lines is $note_lines"
saved_note=$(tail -n "$note_lines" "$inbox_file")
echo saved note is "$saved_note"
if [ "$note" == "$saved_note" ]; then
  echo "Note successfully saved"
  notification_title="Note successfully saved"
  notification_text="$saved_note \n $inbox_file"
else
  echo "Note save unsuccessful"
  notification_title="Note save unsuccessful"
fi

button=$(notify-send "$notification_title" "$notification_text" --action="Edit") #notify
if [[ $button == 0 ]]; then #if edit has been clicked
  if ! inbox=$(zenity --text-info --filename="$inbox_file" --editable); then
    exit
  fi
  backup_file="$backup_folder/$EPOCHSECONDS"
  cp -v "$inbox_file" "$backup_file"
  echo "Backed up inbox to $backup_file"
  echo "$inbox" > "$inbox_file"
fi
