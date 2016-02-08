module Utils where

import Array exposing (Array, get)

zip : List a -> List b -> List (a,b)
zip xs ys =
  case (xs, ys) of
    ( x :: xs', y :: ys' ) -> (x,y) :: zip xs' ys'
    (_, _)                 -> []

genEnumFuncs : List a -> (a -> Int, Int -> a)
genEnumFuncs es =
    let f p1 p2 k =
        case firstOf ((==) k << p1) <| zip es [0..20] of
            Just x  -> p2 x
            Nothing -> Debug.crash "uhh that don't exist"
    in (f fst snd, f snd fst)

firstOf : (a -> Bool) -> List a -> Maybe a
firstOf f xs = List.head <| List.filter f xs

unsafeGet : Array a -> Int -> a
unsafeGet a i =
    case Array.get i a of
        Just x  -> x
        Nothing -> Debug.crash "you promised me this was safe"

