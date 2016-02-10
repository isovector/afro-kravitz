module ChordViewer (view) where 

import Types exposing (..)
import Chords
import ChordDrawing exposing (drawChord)

import Graphics.Element exposing (..)
import Graphics.Collage exposing (collage)

chordSignal : Signal Chord
chordSignal = Signal.constant Chords.a

view : Element
view =
    [drawChord Chords.a] |> collage 800 200

