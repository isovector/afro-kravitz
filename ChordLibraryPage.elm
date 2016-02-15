module ChordLibraryPage (view) where

import Types exposing (..)
import App
import ChordDrawing exposing (drawChordChart, fretboard)
import ChordButton
import Chords
import TypedDict exposing (toList)

import Graphics.Element exposing (..)
import Graphics.Collage exposing (collage, toForm)
import List exposing (map)

chordList : List ChordButton.Model
chordList = toList Chords.knownChords

view : ChordChart -> (Int, Int) -> Signal.Address App.Page -> Element
view chord viewport address =
    let width = fst viewport
        height = snd viewport
        chordButtonViews = flow right (map (ChordButton.view address) chordList)
        chordButtonListView = container width 200 middle chordButtonViews
        activeChordView = collage width 200 [fretboard, drawChordChart chord]
        layout = flow down [activeChordView, chordButtonListView]
    in [toForm layout] |> collage width height

