module ChordLibraryPage (view) where 

import Types exposing (..)
import ChordDrawing exposing (drawChordChart)

import Graphics.Element exposing (..)
import Graphics.Collage exposing (collage)

view : ChordChart -> Element
view chord =
    [drawChordChart chord] |> collage 800 200

