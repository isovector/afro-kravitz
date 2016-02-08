module KeyUtils
    ( semitonesAbove
    , scaleNote
    , buildTriad
    ) where

import Types exposing (..)
import Utils exposing (..)

notes = [C, C', D, D', E, F, F', G, G', A, A', B]

(noteToInt, intToNote) = genEnumFuncs notes

semitonesAbove : Note -> Semitone -> Note
semitonesAbove n s = intToNote <| (noteToInt n + s) % List.length notes

scaleNote : Scale -> Int -> Note
scaleNote (tonic, template) i = semitonesAbove tonic
                             << unsafeGet template
                             <| i % List.length notes

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

