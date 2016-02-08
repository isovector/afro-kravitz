module Types where

type alias ToneIndex = Int
type alias BeatDuration = Float
type alias BeatNumber = Int
type alias Model = (ToneIndex, BeatDuration, BeatNumber, Key)
type Tone = I | II | III | IV | V | VI | VII
type Key = A | B | C | D | E | F | G
type alias Input = Either Action Float
type Either a b  = Left a | Right b
type Action = Increment | Decrement | SetTempo Int
type alias GString = Int

type alias Fret = Int
type Fingering = Finger Int Fret GString
               | Barre Int Fret GString GString
type alias Chord = List Fingering
