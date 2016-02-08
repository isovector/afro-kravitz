module KeyUtils
    ( keyToInt
    ) where

import Types exposing (..)
import Utils exposing (..)

keys  = [A, B, C, D, E, F, G]
tones = [I, II, III, IV, V, VI, VII]

genEnumFuncs : List a -> (a -> Int, Int -> a)
genEnumFuncs es =
    let f p1 p2 k =
        case firstOf ((==) k << p1) <| zip es [0..100] of
            Just x  -> p2 x
            Nothing -> Debug.crash "uhh that don't exist"
    in (f fst snd, f snd fst)

(keyToInt, intToKey)   = genEnumFuncs keys
(toneToInt, intToTone) = genEnumFuncs tones

