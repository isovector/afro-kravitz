module Main where

import App exposing (Page (..), pageSignal, pageBox)
import Timing
import Types exposing (..)
import ChordLibraryPage
import Pages.PlayAlong

import Time exposing (Time)
import Graphics.Element exposing (..)
import Window exposing (dimensions)

main: Signal Element
main = Signal.map App.embedPageTemplate
    <| Signal.map3 router pageSignal Timing.now dimensions

router : (Time, Page) -> Time -> Viewport -> Element
router (start, page) now viewport =
    case page of
        App.ChordLibraryPage chord ->
            ChordLibraryPage.view viewport chord pageBox.address
        About ->
            show "Ariel and Sandy are ridiculously sexy beasts. haha hahaa" -- About.view
        PlayAlong note prog ->
            Pages.PlayAlong.view
                viewport
                (Timing.computeTiming 120 start now)
                note
                prog

