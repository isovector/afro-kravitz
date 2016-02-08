module Model where

import Types exposing (..)

import Array exposing (fromList)

tones = fromList [I, II, III, IV, V, VI, VII]

model : Model
model = { toneIndex = 0
        , timeSpentOnBeat = 0
        , beatNumber = 120
        , key = C 
        }