module Types where

type alias Model = (Int, Float, Int)
type Tone = I | II | III | IV | V | VI | VII
type alias Input = Either Action Float
type Either a b  = Left a | Right b
type Action = Increment | Decrement | SetTempo Int
