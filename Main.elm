module Main where

import App exposing (Page (..), pageSignal, pageBox, tempoBox)
import Timing
import Types exposing (..)
import Pages.ChordLibrary
import Pages.PlayAlong

import Time exposing (Time)
import Graphics.Element exposing (..)
import Graphics.Input.Field exposing (..)
import Window exposing (dimensions)
import String exposing (toInt)

main: Signal Element
main = Signal.map App.embedPageTemplate
    <| Signal.map4 router pageSignal Timing.now dimensions tempoBox.signal

router : (Time, Page) -> Time -> Viewport -> Content -> Element
router (start, page) now viewport tempoContent =
    case page of
        App.ChordLibrary chord ->
            Pages.ChordLibrary.view viewport chord pageBox.address
        About ->
            show "Ariel and Sandy are ridiculously sexy beasts. haha hahaa" -- About.view
        PlayAlong note prog ->
            let bpm = case toInt tempoContent.string of
                    Ok val -> val
                    Err msg -> 1
            in Pages.PlayAlong.view
                viewport
                (Timing.computeTiming bpm start now)
                note
                prog
                tempoContent

