module Types where

type alias Model = { scaleNoteIndex : Int
                   , timeSpentOnBeat : Float
                   , beatNumber : Int
                   , key : Key
                   }
type ScaleNote = I | II | III | IV | V | VI | VII
type Key = A | B | C | D | E | F | G
type alias Input = Either Action Float
type Either a b  = Left a | Right b
type Action = Increment | Decrement | SetTempo Int
type alias GString = Int

type alias Fret = Int
type Fingering = Finger Int Fret GString
               | Barre Int Fret GString GString
type alias Chord = List Fingering
