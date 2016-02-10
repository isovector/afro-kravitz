module TypedDict
    ( Map
    , empty
    , singleton
    , insert
    , update
    , member
    , get
    , values
    , keys
    , fromList
    , toList
    , map
    ) where

import Typeclasses exposing (Ord)
import Dict

type Map k v = Map (Dict.Dict Int v, Ord k)


lift   f       (Map (dict, ord)) = f dict
lift1  f k     (Map (dict, ord)) = f (ord.toInt k) dict
liftM  f k     (Map (dict, ord)) = Map (f (ord.toInt k) dict, ord)
liftM2 f k a   (Map (dict, ord)) = Map (f (ord.toInt k) a dict, ord)
liftM3 f k a b (Map (dict, ord)) = Map (f (ord.toInt k) a b dict, ord)

empty : Ord k -> Map k v
empty ord = Map (Dict.empty, ord)

singleton : Ord k -> k -> v -> Map k v
singleton ord k v = Map (Dict.singleton (ord.toInt k) v, ord)

insert = liftM2 Dict.insert
update = liftM2 Dict.update
member = lift1 Dict.member
get    = lift1 Dict.get
values = lift Dict.values
keys   = List.map fst << toList

fromList ord             = List.foldl (uncurry insert) <| empty ord
toList (Map (dict, ord)) = List.map (\(k, v) -> (ord.fromInt k, v))
                        <| Dict.toList dict
map f  (Map (dict, ord)) = fromList ord
                        << List.map (\(k, v) -> (k, f v))
                        <| Dict.toList dict
