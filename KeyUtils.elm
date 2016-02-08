module KeyUtils
    ( semitones
    ) where

import Types exposing (..)
import Utils exposing (..)

-- keys  = [A, B, C, D, E, F, G]
-- scaleNotes = [I, II, III, IV, V, VI, VII]

genEnumFuncs : List a -> List Int -> (a -> Int, Int -> a)
genEnumFuncs es is =
    let f p1 p2 k =
        case firstOf ((==) k << p1) <| zip es is of
            Just x  -> p2 x
            Nothing -> Debug.crash "uhh that don't exist"
    in (f fst snd, f snd fst)

semitones =
          [      0,  1
          ,  1,  2,  3
          ,  3,  4,  5
          ,  4,  5,  6
          ,  6,  7,  8
          ,  8,  9, 10
          , 10, 11,  0
          , 11
          ]

-- (keyToInt, intToKey)             = genEnumFuncs keys semitones
-- (scaleNoteToInt, intToScaleNote) = genEnumFuncs scaleNotes [0..100]

-- getScaleKey : Key -> ScaleNote -> Key
-- getScaleKey k n = intToKey <| (keyToInt k + scaleNoteToInt n) % List.length keys

