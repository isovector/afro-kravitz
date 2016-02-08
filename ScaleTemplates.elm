module ScaleTemplates where

import Array exposing (fromList, Array)

buildTemplate :: List Int -> Array Int
buildTemplate = fromList << scanl1 (+)

maj :: ScaleTemplate
maj = buildTeplate [0, 2, 2, 1, 2, 2, 2, 1]

harmMin :: ScaleTemplate
harmMin = buildTeplate [0, 2, 1, 2, 2, 1, 2, 1]

chordProgression :: ChordProgression
chordProgression = [ (1, maj)
                   , (6, harmMin)
                   , (4, maj)
                   , (5. maj)
                   , (1, maj)
                   ]

