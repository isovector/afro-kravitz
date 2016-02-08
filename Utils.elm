module Utils where

zip : List a -> List b -> List (a,b)
zip xs ys =
  case (xs, ys) of
    ( x :: xs', y :: ys' ) -> (x,y) :: zip xs' ys'
    (_, _)                 -> []

firstOf : (a -> Bool) -> List a -> Maybe a
firstOf f xs = List.head <| List.filter f xs

