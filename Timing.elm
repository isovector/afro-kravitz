module Timing where

import Signal exposing (..)
import Graphics.Input.Field exposing (Content, noContent)
import Time exposing (..)
import ParseInt exposing (parseInt)

type alias Timing a =
    { a
    | semiquaver : Int
    , quaver     : Int
    , crotchet   : Int
    , minim      : Int
    , semibreve  : Int
    }

clockSignal : Signal Float
clockSignal =
    let dropOldTime newTime (oldTime, _) = (newTime, oldTime)
        timeDelta (newTime, oldTime)     = newTime - oldTime
        timePairSignal = every millisecond |> Signal.foldp dropOldTime (1454745969,0)
    in Signal.map timeDelta timePairSignal

bpmMailbox : Signal.Mailbox Content
bpmMailbox = Signal.mailbox noContent

bpmSignal : Signal Int
bpmSignal = let onBpmChange s = (case parseInt s.string of
                Ok newBpm -> newBpm
                Err _     -> 1
            )
            in Signal.map onBpmChange bpmMailbox.signal

sqps : Int
sqps =
    let bpm = 120
    in 15000 // bpm

foldEvery2 : Int -> Signal Int -> Signal Int
foldEvery2 max = flip foldp 0 (\i -> flip (%) max << (+) (1 - i % 2))
              << dropRepeats

semiquaverSignal : Signal Int
semiquaverSignal = foldp (always <| (+) 1 >> flip (%) 16) 0
                << every <| toFloat sqps

quaverSignal : Signal Int
quaverSignal = foldEvery2 8 semiquaverSignal

crotchetSignal : Signal Int
crotchetSignal = foldEvery2 4 quaverSignal

minimSignal: Signal Int
minimSignal = foldEvery2 2 crotchetSignal

semibreveSignal : Signal Int
semibreveSignal = foldEvery2 16 minimSignal

timingSignal : Signal (Timing {})
timingSignal =
    let f a b c d e =
        { semiquaver = a
        , quaver     = b
        , crotchet   = c
        , minim      = d
        , semibreve  = e
        }
    in Signal.map5 f
           semiquaverSignal
           quaverSignal
           crotchetSignal
           minimSignal
           semibreveSignal

