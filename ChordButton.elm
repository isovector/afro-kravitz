module ChordButton where

import Types exposing(..)
import App
import Chords

import Graphics.Input exposing(..)
import Graphics.Element exposing (..)

type alias Model = ((Note, Quality), Chord)
init : Model
init = 
    ((B, Min), Chords.bm)

view : Signal.Address App.Page -> Model -> Element
view address ((chordNote, chordQuality), chordPaint) = 
    button (Signal.message address <| App.ChordLibraryPage chordPaint) (toString chordNote ++ toString chordQuality)