module Main where

import Graphics.Element exposing (Element, show, flow, down)
import Graphics.Input exposing (button)

import Types exposing (..)
import ChordLibraryPage
import Chords

type Page = About | ChordLibraryPage Chord

pageBox : Signal.Mailbox Page
pageBox =
    Signal.mailbox About

main: Signal Element
main = 
    let renderApp = embedPageTemplate << router
    in Signal.map renderApp pageBox.signal

router : Page -> Element
router page = 
    case page of
        ChordLibraryPage chord -> ChordLibraryPage.view chord 
        About -> show "Ariel and Sandy are ridiculously sexy beasts. haha hahaa" -- About.view 

embedPageTemplate : Element -> Element
embedPageTemplate pageTemplate =
    let pageChangeBtn = button (Signal.message pageBox.address <| ChordLibraryPage Chords.a) "Push it baby"
    in flow down [pageTemplate, pageChangeBtn]