module Timing where

import Signal exposing (..)
import Graphics.Input.Field exposing (Content, noContent)
import Time exposing (..)
import ParseInt exposing (parseInt)

type alias Timing =
    { semiquaver : Int
    , quaver     : Int
    , crotchet   : Int
    , minim      : Int
    , measure    : Int
    }

now : Signal Time
now = every millisecond

computeTiming : Time -> Time -> Timing
computeTiming start now =
    let bpm = 120
        sqps = 15000 // bpm
        dt = round <| now - start

        sq =  dt       % 16
        q  = (dt // 2) % 8
        c  = (dt // 4) % 4
        m  = (dt // 8) % 2
        mm =  dt // 16
    in { semiquaver = sq
       , quaver = q
       , crotchet = c
       , minim = m
       , measure = mm
       }

bpmMailbox : Signal.Mailbox Content
bpmMailbox = Signal.mailbox noContent

bpmSignal : Signal Int
bpmSignal = let onBpmChange s = (case parseInt s.string of
                Ok newBpm -> newBpm
                Err _     -> 1
            )
            in Signal.map onBpmChange bpmMailbox.signal

