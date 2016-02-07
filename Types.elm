module Types where

type alias ToneIndex = Int
type alias BeatDuration = Float
type alias BeatNumber = Int
type alias Model = (ToneIndex, BeatDuration, BeatNumber)
type Tone = I | II | III | IV | V | VI | VII
type alias Input = Either Action Float
type Either a b  = Left a | Right b
type Action = Increment | Decrement | SetTempo Int
type alias GString = Int
