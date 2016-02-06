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

        modelSignal = Signal.foldp update model (Signal.map2 (\i b -> (i,b)) signal bpmSignal)
    in Signal.map2 (view actions.address) modelSignal bpmMailbox.signal

update : (Input, Int) -> Model -> Model
update (input, bpm) (index, time) =
    case input of
        Left action ->
            case action of
                Increment -> (toneIndexAdd index 1, time)
                Decrement -> (toneIndexAdd index -1, time)
                SetTempo newBpm  -> (index, time)
        Right delta ->
            let msPerBeat = 60000 // (if bpm /= 0 then bpm else 120)
                increaseIndexBy = if truncate (time+delta) >= msPerBeat then 1 else 0
            in ( toneIndexAdd index increaseIndexBy
               , toFloat (truncate (time+delta) % msPerBeat)
               )

toneIndexAdd : Int -> Int -> Int
toneIndexAdd a b =
    (a + b) % length tones
