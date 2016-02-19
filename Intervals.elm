module Intervals where

import Debug exposing (trace)
import String

import KeyUtils exposing (..)
import Typeclasses exposing (..)
import Types exposing (..)
import Utils exposing (..)

baseName : Note -> Char
baseName = fromJust << List.head << String.toList << toString

moduloAdd : Ord a -> Maybe (a, a) -> a -> Int -> a
moduloAdd ord rangeMaybe a b =
    let (offset, size) = case rangeMaybe of
            Just (b, t) -> (ord.toInt b, ord.toInt t - ord.toInt b + 1)
            Nothing     -> (0, ord.count)
        ai = ord.toInt a - offset
    in ord.fromInt <| (ai + b) % size + offset

nameOfNote : Note -> Interval -> String
nameOfNote a i =
    let b = intervalAbove a i
        base = baseName a
        newbase = noteRead
               << returnStr
               << moduloAdd charOrd (Just ('A', 'G')) base
               <| intervalSize i - 1
        ai = noteOrd.toInt a
        f = flip (%) 12 << flip (-) ai << noteOrd.toInt
        delta = f newbase - f b
        add = String.repeat (abs delta) <|
                if delta > 0 then "b" else "#"
    in toString newbase ++ add

intervalSize : Interval -> Int
intervalSize x = case x of
    Per1 -> 1
    SemT -> 2
    Tone -> 2
    Min3 -> 3
    Maj3 -> 3
    Per4 -> 4
    TriT -> 4 -- this can go either way, chose 4 arbitrarily
    Per5 -> 5
    Min6 -> 6
    Maj6 -> 6
    Min7 -> 7
    Maj7 -> 7
    Per8 -> 8

