module Pages.ChordLibrary (view) where

import App
import ChordButton
import Components.ChordChart exposing (chordChart)
import Chords
import TypedDict exposing (toList, keys)
import Types exposing (..)

import Graphics.Element exposing (..)
import Graphics.Collage exposing (collage, toForm)
import List exposing (map)

chordList : List ChordButton.Model
chordList = keys Chords.knownChords

view : Viewport -> Chord -> Signal.Address App.Page -> Element
view viewport chord address =
    let width = fst viewport
        chordButtonViews = flow right (map (ChordButton.view address) chordList)
        chordButtonListView = container width 200 middle chordButtonViews
        activeChordView = chordChart chord
        layout = flow down [activeChordView, chordButtonListView]
    in [toForm layout] |> uncurry collage viewport

