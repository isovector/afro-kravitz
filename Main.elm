module Main where

import Types exposing (..)
import View exposing (..)
import Model exposing (..)
import KeyUtils exposing (..)
import Chords
import Utils exposing (..)

import Time exposing (..)
import Array exposing (length)
import Graphics.Element exposing (Element)
import Timing exposing (bpmSignal, bpmMailbox)

chordSignal =
    let f j = Signal.map (unsafeGet (Array.fromList <| List.map (\i -> [Finger i 1 j]) [0..16]))
        sqSig = f 1 Timing.semiquaver
        qSig = f 2 Timing.quaver
        cSig = f 3 Timing.crotchet
        mSig = f 4 Timing.minim
        sbSig = f 5 Timing.semibreve

    in Signal.map5 (\a b c d e -> [a,b,c,d,e])
            sqSig
            qSig
            cSig
            mSig
            sbSig

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
    in Signal.map3 render modelSignal chordSignal bpmMailbox.signal

update : (Float, Int) -> Model -> Model
update (timeDelta, bpm) model =
    let msPerBeat = 60000 // (if bpm /= 0 then bpm else 120)
        increaseBeatNumBy = if truncate (model.timeSpentOnBeat+timeDelta) >= msPerBeat then 1 else 0
        isNewMeasure = (increaseBeatNumBy == 1 && model.beatNumber % 4 == 0)
        increaseIndexBy = if (isNewMeasure) then 1 else 0
    in
        { model | timeSpentOnBeat = toFloat (truncate (model.timeSpentOnBeat+timeDelta) % msPerBeat)
                , beatNumber = model.beatNumber + increaseBeatNumBy
        }
