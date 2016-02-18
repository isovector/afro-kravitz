module ChordButton where

import Types exposing(..)
import App
import Chords

import Graphics.Input exposing(..)
import Graphics.Element exposing (..)

view : Signal.Address App.Page -> Chord -> Element
view address chord = 
    button (Signal.message address <| App.ChordLibrary chord) 
            (toString (fst chord) ++ toString (snd chord))