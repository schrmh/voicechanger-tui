# Voice changer (Terminal User Interface)  

## *A simple voice changer with a dialog frontend. Uses sox.*  



### Usage: `./voicechanger-tui.sh`  
Within the dialog you can e.g. navigate with arrow keys and select the voice modification via the return/enter keys.  
You can change them on-the-fly.  
You can exit the script by pressing `Ctrl+C`.

### Preview:  
![Image showing the Terminal User Interface (TUI) of voicechanger-tui](/voicechanger-tui.png?raw=true "Image showing the Terminal User Interface (TUI) of voicechanger-tui")  

TODO:
- Add new dialog with a range box for a custom pitch
(+ an option to save changes as new sets)
- Add more default presets
- Add an option for noise profile creation (https://unix.stackexchange.com/a/425857)
- Add an option to create a new pulseaudio sink that other apps can use
- Add a switch so that users can choose to hear their own voice (or not)
