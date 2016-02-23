module ScaleTemplates where

import Types exposing (..)
import Array exposing (fromList, Array)

buildTemplate : List Interval -> Array Interval
buildTemplate = fromList << (::) Per1

maj : ScaleTemplate
maj = buildTemplate
    [ Per1
    , Tone
    , Maj3
    , Per4
    , Per5
    , Maj6
    , Maj7
    , Per8
    ]

harMin : ScaleTemplate
harMin = buildTemplate
    [ Per1
    , Tone
    , Min3
    , Per4
    , Per5
    , Min6
    , Maj7
    , Per8
    ]

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
