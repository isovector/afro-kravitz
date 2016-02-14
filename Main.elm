module Main where

import Graphics.Element exposing (Element, show, flow, down)
import Graphics.Input exposing (button)

import ChordLibraryPage
import Chords
import Timing
import Types exposing (..)

type Page = About | ChordLibraryPage Chord

pageBox : Signal.Mailbox Page
pageBox =
    Signal.mailbox About

appModel : Signal Page
appModel =
    pageBox.signal

main: Signal Element
main = Signal.map embedPageTemplate
    <| Signal.map2 router appModel worldSignal

router : Page -> WorldModel -> Element
router page world =
    case page of
        ChordLibraryPage chord -> ChordLibraryPage.view chord
        About -> show "Ariel and Sandy are ridiculously sexy beasts. haha hahaa" -- About.view

embedPageTemplate : Element -> Element
embedPageTemplate pageTemplate =
    let pageChangeBtn = button (Signal.message pageBox.address <| ChordLibraryPage Chords.a) "Push it baby"
    in flow down [pageTemplate, pageChangeBtn]

worldSignal : Signal WorldModel
worldSignal = Timing.timingSignal

