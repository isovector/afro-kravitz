module Utils where

import Array exposing (Array, get)
import String

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

fromJust : Maybe a -> a
fromJust a = case a of
    Just a  -> a
    Nothing -> Debug.crash "fromJust on a Nothing"

unsafeGet : Array a -> Int -> a
unsafeGet a i = fromJust <| Array.get i a

return : a -> List a
return = flip (::) []

returnStr: Char -> String
returnStr = String.fromList << return

last : List a -> a
last = fromJust << List.head << List.reverse

ordinal : Int -> String
ordinal i = toString i ++ case i of
    1  -> "st"
    2  -> "nd"
    3  -> "rd"
    21 -> "st"
    22 -> "nd"
    23 -> "rd"
    _  -> "th"

