module KeyUtils
    ( semitonesAbove
    , scaleNote
    , buildTriad
    , nameOfRelativeChord
    ) where

import String
import Types exposing (..)
import Utils exposing (..)

nameOfRelativeChord : Int -> Quality -> String
nameOfRelativeChord c q =
    let transform =
        case q of
            Maj -> identity
            Min -> String.toLower
    in transform <| case c of
        1 -> "I"
        2 -> "II"
        3 -> "III"
        4 -> "IV"
        5 -> "V"
        6 -> "VI"
        7 -> "VII"
        _ -> Debug.crash "that is not a chord"


semitonesAbove : Note -> Semitone -> Note
semitonesAbove n s = noteOrd.fromInt
                  <| (noteOrd.toInt n + s) % noteEnum.count

scaleNote : Scale -> Int -> Note
scaleNote (tonic, template) i = semitonesAbove tonic
                             << unsafeGet template
                             <| i % noteEnum.count

-- TODO(sandy): this might not make a huge amount of sense as it's
-- parameterized
buildTriad : Scale -> (Int, ScaleTemplate) -> List Note
buildTriad base (i, template) =
    let scale = (scaleNote base i, template)
        note = scaleNote scale
    in [ note 1
       , note 3
       , note 5
       ]

