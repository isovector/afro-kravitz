module Main where

import Graphics.Element exposing (Element, show)

import Types exposing (..)
import ChordViewer
import Chords

type Page = About | ChordViewer Chord

pageSignal : Signal Page
pageSignal = Signal.constant <| ChordViewer Chords.bm

main: Signal Element
main = 
    Signal.map (router >> viewNavbar) pageSignal

router : Page -> Element
router page = 
    case page of
        ChordViewer chord-> ChordViewer.view chord
        About -> show "Ariel and Sandy are ridiculously sexy beasts. haha hahaa" -- About.view

viewNavbar : Element -> Element
viewNavbar myspace =
    myspace