module Main where

import Graphics.Element exposing (Element, show, flow, down)
import Graphics.Input exposing (button)

import Types exposing (..)
import ChordViewer
import Chords

type Page = About | ChordViewer Chord

pageBox : Signal.Mailbox Page
pageBox =
    Signal.mailbox About

main: Signal Element
main = 
     Signal.map (router >> viewNavbar) pageBox.signal

router : Page -> Element
router page = 
    case page of
        ChordViewer chord-> ChordViewer.view chord
        About -> show "Ariel and Sandy are ridiculously sexy beasts. haha hahaa" -- About.view

viewNavbar : Element -> Element
viewNavbar myspace =
    let pageChangeBtn = button (Signal.message pageBox.address <| ChordViewer Chords.a) "Push it baby"
    in flow down [myspace, pageChangeBtn]