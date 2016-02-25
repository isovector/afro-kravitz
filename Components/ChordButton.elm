module Components.ChordButton where

import Types exposing(..)

import Graphics.Input exposing(..)
import Graphics.Element exposing (..)

view : (Chord -> a) -> Signal.Address a -> Chord -> Element
view f address chord = 
    button (Signal.message address <| f chord) 
            (toString (fst chord) ++ toString (snd chord))