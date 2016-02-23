module Typeclasses where

import Char
import Debug
import Dict

import Utils exposing (..)

type alias Enum a = { elems : List a, count : Int }
derivingEnum : List a -> Enum a
derivingEnum elems = { elems = elems
                     , count = List.length elems
                     }


type alias Ord a = { elems   : List a
                   , count   : Int
                   , toInt   : a -> Int
                   , fromInt : Int -> a
                   }
derivingOrd : Enum a -> Ord a
derivingOrd enum =
    let (toInt, fromInt) = genEnumFuncs enum.elems
    in { elems   = enum.elems
       , count   = enum.count
       , toInt   = toInt
       , fromInt = fromInt
       }

liftOrd : Ord a -> Ord b -> Ord (a, b)
liftOrd ordA ordB =
    { elems = List.concat
           << flip  List.map         ordA.elems
           <| \a -> List.map ((,) a) ordB.elems
    , count = ordA.count * ordB.count
    , toInt = \(a, b) -> ordA.toInt a * ordB.count + ordB.toInt b
    , fromInt = \i ->
        ( ordA.fromInt <| i // ordB.count
        , ordB.fromInt <| i %  ordB.count
        )
    }

type alias Read a = String -> a
derivingRead : Enum a -> Read a
derivingRead enum =
    let dict = Dict.fromList
            << flip List.map enum.elems
            <| \a -> (toString a, a)
        safetyFirst a = case a of
            Just x  -> x
            Nothing -> Debug.crash "safety first"
    in safetyFirst << flip Dict.get dict

-- Common Types

charOrd =
    { elems = List.map Char.fromCode [0..255]
    , count = 256
    , toInt = Char.toCode
    , fromInt = Char.fromCode
    }
charRead = List.head

