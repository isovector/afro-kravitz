module ChordViewer (view) where 

import Types exposing (..)
import Chords
import ChordDrawing exposing (drawChord)

import Graphics.Element exposing (..)
import Graphics.Collage exposing (collage)

chordSignal : Signal Chord
chordSignal = Signal.constant Chords.a

view : Chord -> Element
view chord =
    [drawChord chord] |> collage 800 200

