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

        modelSignal = Signal.map2 (,) signal bpmSignal
                   |> Signal.foldp update model
    in Signal.map2 (view actions.address) modelSignal bpmMailbox.signal

update : (Input, Int) -> Model -> Model
update (input, bpm) model =
    case input of
        Left action ->
            case action of
                Increment -> { model | toneIndex = toneIndexAdd model.toneIndex 1 }
                Decrement -> { model | toneIndex = toneIndexAdd model.toneIndex -1 }
                SetTempo newBpm  -> model
        Right delta ->
            let msPerBeat = 60000 // (if bpm /= 0 then bpm else 120)
                increaseBeatNumBy = if truncate (model.timeSpentOnBeat+delta) >= msPerBeat then 1 else 0
                isNewMeasure = (increaseBeatNumBy == 1 && model.beatNumber % 4 == 0)
                increaseIndexBy = if (isNewMeasure) then 1 else 0
            in 
                { model | toneIndex = toneIndexAdd model.toneIndex increaseIndexBy
                        , timeSpentOnBeat = toFloat (truncate (model.timeSpentOnBeat+delta) % msPerBeat)
                        , beatNumber = model.beatNumber + increaseBeatNumBy
                }

toneIndexAdd : Int -> Int -> Int
toneIndexAdd a b =
    (a + b) % length tones
