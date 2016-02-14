module Main where

import App exposing (pageBox)
import Timing
import Types exposing (..)
import ChordLibraryPage

import Graphics.Element exposing (..)

main: Signal Element
main = Signal.map App.embedPageTemplate
    <| Signal.map2 router pageBox.signal worldSignal

router : App.Page -> WorldModel -> Element
router page world = 
    case page of
        App.ChordLibraryPage chord -> ChordLibraryPage.view chord pageBox.address
        App.About -> show "Ariel and Sandy are ridiculously sexy beasts. haha hahaa" -- About.view 

worldSignal : Signal WorldModel
worldSignal = Timing.timingSignal

