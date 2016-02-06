module Main where

import Types exposing (..)
import View exposing (..)
import Model exposing (..)

import Time exposing (..)
import Array exposing (length)

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


