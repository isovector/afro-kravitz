module Timing where

import View exposing (bpmSignal)
import Signal exposing (..)
import Time exposing (..)


sqps : Int
sqps =
    let bpm = 120
    in 60000 // bpm * 4

foldEvery2 : Int -> Signal Int -> Signal Int
foldEvery2 = flip foldp 0 << \i -> (+) (1 - i % 2) >> (%)

semiquaver : Signal Int
semiquaver = foldp (always <| (+) 1 >> (%) 16) 0
          << every <| toFloat sqps

quaver : Signal Int
quaver = foldEvery2 8 semiquaver

crotchet : Signal Int
crotchet = foldEvery2 4 quaver

minim: Signal Int
minim = foldEvery2 2 crotchet

semibreve : Signal Int
semibreve = foldEvery2 1 minim

