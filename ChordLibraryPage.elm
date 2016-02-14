module ChordLibraryPage (view) where

import Types exposing (..)
import App
import ChordDrawing exposing (drawChord)
import ChordButton

import Graphics.Element exposing (..)
import Graphics.Collage exposing (collage, toForm)
import List exposing (map)

type alias Model = List ChordButton.Model
model : Model
model = [ChordButton.init]

view : Chord -> Signal.Address App.Page -> Element
view chord address =
    let chordButtons = map (toForm << ChordButton.view address) model
    in chordButtons ++ [drawChord chord] |> collage 800 200

