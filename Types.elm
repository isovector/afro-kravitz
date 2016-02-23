module Types where

import Array exposing (Array)
import Typeclasses

type alias Viewport = (Int, Int)

type alias GString = Int
type alias Fret = Int
type Fingering = Finger Int Fret GString
               | Barre Int Fret GString GString
type alias ChordChart = List Fingering

type Quality = Maj | Min
qualityEnum = Typeclasses.derivingEnum [Maj, Min]
qualityOrd  = Typeclasses.derivingOrd qualityEnum
qualityRead = Typeclasses.derivingRead qualityEnum

type Note = C | C' | D | D' | E | F | F' | G | G' | A | A' | B
noteEnum = Typeclasses.derivingEnum [C, C', D, D', E, F, F', G, G', A, A', B]
noteOrd  = Typeclasses.derivingOrd noteEnum
noteRead = Typeclasses.derivingRead noteEnum

type Interval = Per1 | SemT | Tone | Min3 | Maj3 | Per4 | TriT | Per5
              | Min6 | Maj6 | Min7 | Maj7 | Per8
intervalEnum = Typeclasses.derivingEnum
    [Per1, SemT, Tone, Min3, Maj3, Per4, TriT, Per5, Min6, Maj6, Min7, Maj7, Per8]
intervalOrd  = Typeclasses.derivingOrd intervalEnum
intervalRead = Typeclasses.derivingRead intervalEnum

type alias Chord = (Note, Quality)
chordOrd = Typeclasses.liftOrd noteOrd qualityOrd

type alias ScaleTemplate = Array Interval
type alias Scale = (Note, ScaleTemplate)
type alias ChordProgression = Array ((Int, Quality))

