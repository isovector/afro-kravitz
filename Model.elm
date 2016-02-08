module Model where

import Types exposing (..)

import Array exposing (fromList)

tones = fromList [I, II, III, IV, V, VI, VII]

model : Model
model = (0, 0, 120, C)