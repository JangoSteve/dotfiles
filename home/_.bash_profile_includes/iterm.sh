tab() # new tab from current dir
{
arch -i386 osascript -e "
tell application \"iTerm\"
  make new terminal
  tell the current terminal
    activate current session
    launch session \"Default Session\"
    tell the last session
      write text \"cd $(pwd)\"
    end tell
  end tell
end tell"
}
alias t="tab"
