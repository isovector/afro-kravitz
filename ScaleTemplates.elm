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
chordProgression = [ (1, maj)
                   , (6, harMin)
                   , (4, maj)
                   , (5, maj)
                   , (1, maj)
                   ]

