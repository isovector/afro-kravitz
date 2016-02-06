module Main where

import Types exposing (..)
import View exposing (..)
import Model exposing (..)

import Time exposing (..)
import Array exposing (length)

-- main : Signal Html.Html
main =
    let actions = Signal.mailbox Increment
        dropOldTime newTime (oldTime, _) = (newTime, oldTime)
        timeDelta (newTime, oldTime)     = newTime - oldTime
        timePairSignal = every millisecond
                      |> Signal.foldp dropOldTime (1454745969,0)
        signal =
            Signal.merge
                (Signal.map Left actions.signal)
                (Signal.map (timeDelta >> Right) timePairSignal)

        modelSignal = Signal.foldp update model signal
    in Signal.map (view actions.address) modelSignal

update : Input -> (Model -> Model)
update input (index, time, bpm) =
    case input of
        Left action ->
            case action of
                Increment -> (toneIndexAdd index 1, time, bpm)
                Decrement -> (toneIndexAdd index -1, time, bpm)
                SetTempo newBpm  -> (index, time, newBpm)
        Right delta ->
            let msPerBeat = 60000 // bpm
                increaseIndexBy = if truncate (time+delta) >= msPerBeat then 1 else 0
            in ( toneIndexAdd index increaseIndexBy
               , toFloat (truncate (time+delta) % msPerBeat)
               , bpm
               )

toneIndexAdd : Int -> Int -> Int
toneIndexAdd a b =
    (a + b) % length tones
