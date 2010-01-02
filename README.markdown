# Delete Immediately
A standalone Mac OS X 10.6 Snow Leopard Service to delete files and folders immediately, bypassing the Trash.
By Jacob Bandes-Storch (a.k.a. jtbandes), 2009.

## Info
This service takes care of the common request for the ability to delete files in Finder without them going to the Trash. A common solution was to open Terminal and use `rm(1)`, which was tedious. This Service appears in the Services menu and the Finder context menu, allowing quick and easy deletion of files and folders without the Trash. It even works on files that are already in the Trash!

## Notes
- By default, the service pops up a warning/confirmation dialog before you delete a file. The code which adds a "Don't show this warning again" checkbox has been intentionally commented out to prevent users from making bad mistakes. However, the service still respects the (now hidden) preference to bypass this confirmation. If you really want to do this, and you promise not to delete any important files by accident, you have two options:
  - Uncomment the relevant code and build your own version of the service
  - Use this Terminal command:  
    `defaults write net.bandes-storch.Delete-Immediately DIWarnBeforeDelete -bool NO`

## Todo
- Delete Immediately needs an icon!
- Localize into other languages
