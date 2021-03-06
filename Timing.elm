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

computeTiming : Int -> Time -> Time -> Timing
computeTiming bpm start now =
    let sqps = 15000 / toFloat bpm
        dt   = round <| (now - start) / sqps

        sq =  dt       % 16
        q  = (dt // 2) % 8
        c  = (dt // 4) % 4
        m  = (dt // 8) % 2
        mm =  dt // 16
    in { semiquaver = sq
       , quaver     = q
       , crotchet   = c
       , minim      = m
       , measure    = mm
       }