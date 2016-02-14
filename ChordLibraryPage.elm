module ChordLibraryPage (view) where

import Types exposing (..)
import App
import ChordDrawing exposing (drawChord, fretboard)
import ChordButton
import Chords
import TypedDict exposing (toList)

import Graphics.Element exposing (..)
import Graphics.Collage exposing (collage, toForm)
import List exposing (map)

chordList : List ChordButton.Model
chordList = toList Chords.knownChords

view : Chord -> Viewport a -> Signal.Address App.Page -> Element
view chord viewport address =
    let chordButtons = flow right (map (ChordButton.view address) chordList)
        activeChordView = collage viewport.width 100 [fretboard, drawChord chord]
        layout = flow down [activeChordView, chordButtons]
    in [toForm layout] |> collage viewport.width 200

