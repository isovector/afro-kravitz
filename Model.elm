module Model where

import Types exposing (..)

import Array exposing (fromList)

scaleNotes = fromList [I, II, III, IV, V, VI, VII]

model : Model
model = { scaleNoteIndex = 0
        , timeSpentOnBeat = 0
        , beatNumber = 120
        , key = C
        }
