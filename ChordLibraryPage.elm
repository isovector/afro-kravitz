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

view : ChordChart -> Viewport a -> Signal.Address App.Page -> Element
view chord viewport address =
    let chordButtonViews = flow right (map (ChordButton.view address) chordList)
        chordButtonListView = container viewport.width 200 middle chordButtonViews
        activeChordView = collage viewport.width 200 [fretboard, drawChordChart chord]
        layout = flow down [activeChordView, chordButtonListView]
    in [toForm layout] |> collage viewport.width viewport.height

