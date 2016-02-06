module View where

import Types exposing (..)
import Model exposing (..)

import Graphics.Element exposing (Element (..), show, flow, right, centered, spacer)
import Graphics.Collage exposing (Form (..), collage, toForm, text)
import Html exposing (div, button, span, input)
import Html.Events exposing (onClick, on, targetValue)
import Html.Attributes exposing (class, style)
import ParseInt exposing (parseInt)
import List exposing (concat)
import Array exposing (fromList, get, length, map, toList)
import Color exposing (red)
import Text exposing (Text (..), fromString, color)

redText : Int -> Tone -> List Element
redText index chord =
    let selected = get index tones
        isSelected = Just chord == selected
        styling = if isSelected then color red else identity
        label = toString chord |> fromString |> styling |> centered
    in [label, spacer 10 1]

view : Signal.Address Action -> Model -> Element
view address (index, time, bpm) =
    let buttonJob action string = button [ onClick address action ] [ Html.text string ]

        onBmpChange s = (case parseInt s of
            Ok newBpm -> SetTempo newBpm
            Err _     -> SetTempo bpm
        ) |> Signal.message address

        elems = [ buttonJob Decrement "-"
                , buttonJob Increment "+"
                , input [ on "input" targetValue onBmpChange ] []
                ]

        layout = flow right (toList (map (\tone -> redText index tone) tones) |> concat)

    in [toForm layout] |> collage 800 200