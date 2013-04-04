module Main where

import Graphics.UI.Gtk
import Graphics.UI.Gtk.Builder

main = do
    initGUI
    builder <- builderNew
    builderAddFromFile builder "dep.glade"
    initWindow <- builderGetObject builder castToWindow "chapterpicker"
    onDestroy initWindow mainQuit
    widgetShowAll mainWindow
    mainGUI
