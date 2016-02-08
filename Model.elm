module Model where

import Types exposing (..)

import Array exposing (fromList)

model : Model
model = { scaleNoteIndex = 0
        , timeSpentOnBeat = 0
        , beatNumber = 120
        }
