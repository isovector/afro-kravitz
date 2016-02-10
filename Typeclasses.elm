module Typeclasses where

-- Unfortunately we can't make a type for these typeclasses, because
-- elm's type system is shitty, so any function which uses one needs
-- to drop its type signature.

import Utils exposing (..)

type alias Ord a = { toInt : a -> Int, fromInt : Int -> a }

derivingOrd : List a -> Ord a
derivingOrd c = let (toInt, fromInt) = genEnumFuncs c
                in { toInt = toInt, fromInt = fromInt }

liftOrd : Ord a -> Ord b -> Ord (a, b)
liftOrd ordA ordB =
    { toInt = \(a, b) -> ordA.toInt a * 100 + ordB.toInt b
    , fromInt = \i    -> (ordA.fromInt <| i // 100, ordB.fromInt <| i % 100)
    }
