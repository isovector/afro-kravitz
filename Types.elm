module Types where

import Array exposing (Array)
import Typeclasses

type alias Model = { scaleNoteIndex : Int
                   , timeSpentOnBeat : Float
                   , beatNumber : Int
                   }

type alias WorldModel =
    { semiquaver : Int
    , quaver     : Int
    , crotchet   : Int
    , minim      : Int
    , semibreve  : Int
    }

type alias Input = Either Action Float
type Either a b  = Left a | Right b
type Action = Increment | Decrement | SetTempo Int
type alias GString = Int

type alias Fret = Int
type Fingering = Finger Int Fret GString
               | Barre Int Fret GString GString
type alias Chord = List Fingering

type Quality = Maj | Min
qualityEnum = Typeclasses.derivingEnum [Maj, Min]
qualityOrd  = Typeclasses.derivingOrd qualityEnum

type Note = C | C' | D | D' | E | F | F' | G | G' | A | A' | B
noteEnum = Typeclasses.derivingEnum [C, C', D, D', E, F, F', G, G', A, A', B]
noteOrd  = Typeclasses.derivingOrd noteEnum

type alias Semitone = Int
type alias ScaleTemplate = Array Semitone -- length 7
type alias Scale = (Note, ScaleTemplate)
type alias ChordProgression = List ((Int, ScaleTemplate))

