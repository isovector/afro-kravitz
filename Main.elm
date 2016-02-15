module Main where

import App exposing (pageSignal, pageBox)
import Timing
import Types exposing (..)
import ChordLibraryPage

import Time exposing (Time)
import Graphics.Element exposing (..)
import Window exposing (dimensions)

main: Signal Element
main = Signal.map App.embedPageTemplate
    <| Signal.map3 router pageSignal Timing.now dimensions

router : (Time, App.Page) -> Time -> (Int, Int) -> Element
router (start, page) now world =
    case page of
        App.ChordLibraryPage chord -> ChordLibraryPage.view chord world pageBox.address
        App.About -> show "Ariel and Sandy are ridiculously sexy beasts. haha hahaa" -- About.view

