module View where

import Types exposing (..)
import Model exposing (..)

import Graphics.Element exposing (Element (..), show, flow, right, down, centered, spacer)
import Graphics.Collage exposing (Form (..), collage, toForm, text)
import Graphics.Input.Field exposing (field, noContent, defaultStyle)
import ParseInt exposing (parseInt)
import List exposing (concat)
import Array exposing (fromList, get, length, map, toList)
import Color exposing (red)
import Text exposing (Text (..), fromString, color)

view : Signal.Address Action -> Model -> Element
view address model =
    flow down [viewChords model, showUi address]
    
showUi : Signal.Address Action -> Element
showUi address  = 
    let onBpmChange s = (case parseInt s.string of
            Ok newBpm -> SetTempo newBpm
            Err _     -> SetTempo 1
        ) |> Signal.message address
    in field defaultStyle onBpmChange "BPM" noContent
    
    
redText : Int -> Tone -> List Element
redText index chord =
    let selected = get index tones
        isSelected = Just chord == selected
        styling = if isSelected then color red else identity
        label = toString chord |> fromString |> styling |> centered
    in [label, spacer 10 1]

viewChords : Model -> Element
viewChords (index, time, bpm) =
    let layout = flow right (toList (map (\tone -> redText index tone) tones) |> concat)
    in [toForm layout] |> collage 800 200