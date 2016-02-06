module Main where

import Html exposing (div, button, text, span, input)
import Html.Events exposing (onClick, on, targetValue)
import Html.Attributes exposing (class, style)
import StartApp.Simple as StartApp
import Array exposing (fromList, get, length, map, toList)
import Time exposing (..)
import ParseInt exposing (parseInt)

main : Signal Html.Html
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

chords = fromList ["C", "D", "E", "F", "G", "A", "B"]

type alias Model = (Int, Float, Int)
model : Model
model = (0, 0, 120)

redText : Int -> String -> Html.Html
redText index chord = 
    let selected = get index chords
        isSelected = Just chord == selected 
        styling = if isSelected then [("color", "red")] else []
    in span [ style styling ] [ text chord ]

view : Signal.Address Action -> Model -> Html.Html
view address (index, time, bpm) =
    div []
        (toList (map (redText index) chords) ++
            [ button [ onClick address Decrement ] [ (truncate time) |> toString |> text ]
            , button [ onClick address Increment ] [ text "+" ]
            , input [ on "input" targetValue (\s -> case parseInt s of 
                Ok newBpm -> Signal.message address (SetTempo newBpm)
                Err _ -> Signal.message address (SetTempo 1) 
            ) ][]
            ])
        
        
type Action = Increment | Decrement | SetTempo Int

update : Input -> (Model -> Model)
update input (index, time, bpm) = 
    case input of 
        Left action -> 
            case action of
                Increment -> ((index + 1) % length chords, time, bpm)
                Decrement -> ((index - 1) % length chords, time, bpm)
                SetTempo newBpm  -> (index, time, newBpm)
        Right delta -> 
            let msPerBeat = 60000 // bpm
                increaseIndexBy = if truncate (time+delta) >= msPerBeat then 1 else 0
            in ((index+increaseIndexBy) % length chords
                , toFloat (truncate (time+delta) % msPerBeat)
                , bpm)
    
type alias Input = Either Action Float
type Either a b  = Left a | Right b
