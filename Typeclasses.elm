module Typeclasses where

-- Unfortunately we can't make a type for these typeclasses, because
-- elm's type system is shitty, so any function which uses one needs
-- to drop its type signature.

import Utils exposing (..)

type alias Enum a = { elems : List a, count : Int }
derivingEnum : List a -> Enum a
derivingEnum elems = { elems = elems
                     , count = List.length elems }


type alias Ord a = { toInt : a -> Int, fromInt : Int -> a }
derivingOrd : Enum a -> Ord a
derivingOrd enum =
    let (toInt, fromInt) = genEnumFuncs enum.elems
    in { toInt = toInt, fromInt = fromInt }

-- TODO(sandy): Don't depend on this too hard, it's pretty easy to
-- get non-unique ords when composing.
liftOrd : Ord a -> Ord b -> Ord (a, b)
liftOrd ordA ordB =
    { toInt = \(a, b) -> ordA.toInt a * 100 + ordB.toInt b
    , fromInt = \i    -> (ordA.fromInt <| i // 100, ordB.fromInt <| i % 100)
    }
