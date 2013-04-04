module Main where

import Graphics.UI.Gtk
import Graphics.UI.Gtk.Builder

main = do
    initGUI
    builder <- builderNew
    builderAddFromFile builder "dep.glade"
    mainWindow <- builderGetObject builder castToWindow "chapterpicker"
    onDestroy mainWindow mainQuit
    widgetShowAll mainWindow
    mainGUI
--      initGUI
--      Just xml <- xmlNew "dep.glade"
--      window   <- xmlGetWidget xml castToWindow "chapterwindow"
--     onDestroy window mainQuit
--     widgetShowAll window
--     mainGUI
