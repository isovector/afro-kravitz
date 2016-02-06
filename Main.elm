module Main where

import Html exposing (div, button, span, input)
import Html.Events exposing (onClick, on, targetValue)
import List exposing (concat)
import Html.Attributes exposing (class, style)
import StartApp.Simple as StartApp
import Array exposing (fromList, get, length, map, toList)
import Time exposing (..)
import ParseInt exposing (parseInt)
import Graphics.Element exposing (Element (..), show, flow, right, centered, spacer)
import Graphics.Collage exposing (Form (..), collage, toForm, text)
import Color exposing (red)
import Text exposing (Text (..), fromString, color)

-- main : Signal Html.Html
main =
    let
        actions = Signal.mailbox Increment

        newTimeOldTimePairSignal = Signal.foldp newTimeOldTimePairJob (1454745969,0) (every millisecond)
        newTimeOldTimePairJob newTime (oldTime, _) = (newTime, oldTime)

        timeSignal = Signal.map (\(newTime, oldTime) -> newTime - oldTime)newTimeOldTimePairSignal

        signal : Signal Input
        signal = Signal.merge (Signal.map Left actions.signal) (Signal.map Right (timeSignal))

        modelSignal = Signal.foldp update model signal
    in
        Signal.map (view actions.address) modelSignal

type Tone = I | II | III | IV | V | VI | VII
tones = fromList [I, II, III, IV, V, VI, VII]

type alias Model = (Int, Float, Int)
model : Model
model = (0, 0, 120)

-- redText : Int -> Tone -> Html.Html
-- redText index chord =
--     let selected = get index tones
--         isSelected = Just chord == selected
--         styling = if isSelected then [("color", "red")] else []
--     in span [ style (("margin-right", "10px") :: styling )] [ toString chord |> text ]

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
       -- div [] elems
        -- (collage 200 200 [toList (map (redText index) tones) |> show |> toForm]) ++
        --     []


type Action = Increment | Decrement | SetTempo Int

update : Input -> (Model -> Model)
update input (index, time, bpm) =
    case input of
        Left action ->
            case action of
                Increment -> ((index + 1) % length tones, time, bpm)
                Decrement -> ((index - 1) % length tones, time, bpm)
                SetTempo newBpm  -> (index, time, newBpm)
        Right delta ->
            let msPerBeat = 60000 // bpm
                increaseIndexBy = if truncate (time+delta) >= msPerBeat then 1 else 0
            in ((index+increaseIndexBy) % length tones
                , toFloat (truncate (time+delta) % msPerBeat)
                , bpm)

type alias Input = Either Action Float
type Either a b  = Left a | Right b
