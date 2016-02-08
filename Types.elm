module Types where

import Array exposing (Array)

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

type Note =      C | C'
          | Db | D | D'
          | Eb | E | E'
          | Fb | F | F'
          | Gb | G | G'
          | Ab | A | A'
          | Bb | B | B'
          | Cb

type alias Semitone = Int
type alias ScaleTemplate = Array Semitone -- length 7
type alias Scale = (Note, ScaleTemplate)
type alias ChordProgression = List ((Int, ScaleTemplate))
