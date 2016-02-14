module ChordLibraryPage (view) where

import Types exposing (..)
import ChordDrawing exposing (drawChord)

import Graphics.Element exposing (..)
import Graphics.Collage exposing (collage)

view : Chord -> Element
view chord =
    [drawChord chord] |> collage 800 200

