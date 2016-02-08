module Main where

import Types exposing (..)
import View exposing (..)
import Model exposing (..)
import KeyUtils exposing (..)

import Time exposing (..)
import Array exposing (length)
import Graphics.Element exposing (Element)

main : Signal Element
main =
    let dropOldTime newTime (oldTime, _) = (newTime, oldTime)
        timeDelta (newTime, oldTime)     = newTime - oldTime
        timePairSignal = every millisecond
                      |> Signal.foldp dropOldTime (1454745969,0)
        clockSignal =
                Signal.map timeDelta timePairSignal

        modelSignal = Signal.map2 (,) clockSignal bpmSignal
                   |> Signal.foldp update model
    in Signal.map2 render modelSignal bpmMailbox.signal

update : (Float, Int) -> Model -> Model
update (timeDelta, bpm) model =
    let msPerBeat = 60000 // (if bpm /= 0 then bpm else 120)
        increaseBeatNumBy = if truncate (model.timeSpentOnBeat+timeDelta) >= msPerBeat then 1 else 0
        isNewMeasure = (increaseBeatNumBy == 1 && model.beatNumber % 4 == 0)
        increaseIndexBy = if (isNewMeasure) then 1 else 0
    in
        { model | scaleNoteIndex = scaleNoteIndexAdd model.scaleNoteIndex increaseIndexBy
                , timeSpentOnBeat = toFloat (truncate (model.timeSpentOnBeat+timeDelta) % msPerBeat)
                , beatNumber = model.beatNumber + increaseBeatNumBy
        }

scaleNoteIndexAdd : Int -> Int -> Int
scaleNoteIndexAdd a b =
    (a + b) % length scaleNotes
