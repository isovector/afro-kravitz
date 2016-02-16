module ScaleTemplates where

import Types exposing (..)
import Array exposing (fromList, Array)

buildTemplate : List Int -> Array Int
buildTemplate = fromList << List.scanl (+) 0

maj : ScaleTemplate
maj = buildTemplate [0, 2, 2, 1, 2, 2, 2, 1]

harMin : ScaleTemplate
harMin = buildTemplate [0, 2, 1, 2, 2, 1, 2, 1]

chordProgression : ChordProgression
chordProgression = fromList
    [ (1, Maj)
    , (6, Min)
    , (4, Maj)
    , (5, Maj)
    , (1, Maj)
    ]

getScaleTemplate : Quality -> ScaleTemplate
getScaleTemplate q =
    case q of
        Maj -> maj
        Min -> harMin
