module Types where

import Array exposing (Array)
import Typeclasses

type alias Model = { scaleNoteIndex : Int
                   , timeSpentOnBeat : Float
                   , beatNumber : Int
                   }

type alias Input = Either Action Float
type Either a b  = Left a | Right b
type Action = Increment | Decrement | SetTempo Int
type alias GString = Int

type alias Fret = Int
type Fingering = Finger Int Fret GString
               | Barre Int Fret GString GString
type alias Chord = List Fingering

type Note = C | C' | D | D' | E | F | F' | G | G' | A | A' | B
notes = [C, C', D, D', E, F, F', G, G', A, A', B]
noteOrd = Typeclasses.derivingOrd notes

type alias Semitone = Int
type alias ScaleTemplate = Array Semitone -- length 7
type alias Scale = (Note, ScaleTemplate)
type alias ChordProgression = List ((Int, ScaleTemplate))
