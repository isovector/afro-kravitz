module Timing where

import Signal exposing (..)
import Graphics.Input.Field exposing (Content, noContent)
import Time exposing (..)
import ParseInt exposing (parseInt)

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

semiquaver : Signal Int
semiquaver = foldp (always <| (+) 1 >> flip (%) 16) 0
          << every <| toFloat sqps

quaver : Signal Int
quaver = foldEvery2 8 semiquaver

crotchet : Signal Int
crotchet = foldEvery2 4 quaver

minim: Signal Int
minim = foldEvery2 2 crotchet

semibreve : Signal Int
semibreve = foldEvery2 1 minim

