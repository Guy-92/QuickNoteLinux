# QuickNoteLinux
A way to take quick notes in Obsidian on Linux

This project is a way to take quick notes in Linux. By default, it uses Kdialog, but Zenity can be used instead.

## Requirements

The script needs either Zenity or Kdialog installed on the system


## Configuration:

In the script, add the path to the inbox file, choose if you would like to use Zenity or kdialog by commenting and uncommenting the relevant lines, and choose if you would like a Zenity multiline dialog or not by commenting or uncommenting the `zenity_multiline` line.

If you choose the have the Zenity multiline dialog, then the Enter key will add a newline, and you will need to press ctrl+tab twice, then Enter to add the note. And if you choose to not use the multiline dialog, then pressing enter will add the note. 

If you use Kdialog instead of Zenity, then the Enter key will create a newline, and you will need to press ctrl+Enter to add the note.

In KDE, you can map a keyboard shortcut to the script.
