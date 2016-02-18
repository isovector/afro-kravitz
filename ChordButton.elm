module ChordButton where

import Types exposing(..)
import App
import Chords

import Graphics.Input exposing(..)
import Graphics.Element exposing (..)

type alias Model = (Note, Quality)
init : Model
init = (B, Min)

view : Signal.Address App.Page -> Model -> Element
view address chord = 
    button (Signal.message address <| App.ChordLibrary chord) 
            (toString (fst chord) ++ toString (snd chord))