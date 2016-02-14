module Typeclasses where

-- Unfortunately we can't make a type for these typeclasses, because
-- elm's type system is shitty, so any function which uses one needs
-- to drop its type signature.

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

