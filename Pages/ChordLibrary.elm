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

chordList : List Chord
chordList = keys Chords.knownChords

view : Viewport -> Chord -> Signal.Address App.Page -> Element
view viewport chord address =
    let width = fst viewport
        height = (snd viewport) // 2
        chordButtonViews = flow right (map (ChordButton.view address) chordList)
        chordButtonListView = container width 200 middle chordButtonViews
        activeChordView = container width 200 middle (chordChart chord) 
        layout = flow down [activeChordView, chordButtonListView]
    in collage width height [toForm layout]

