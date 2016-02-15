module Pages.PlayAlong where

import Array
import Debug
import List
import Types exposing (..)
import Chords
import ChordDrawing exposing (drawChordChart, fretboard)
import Graphics.Element exposing (..)
import Timing exposing (..)
import KeyUtils exposing (nameOfRelativeChord, scaleNote)
import ScaleTemplates exposing (getScaleTemplate)
import TypedDict
import Utils exposing (..)

import Graphics.Collage exposing (Form (..), collage, toForm, text, filled, moveX, moveY, rect, circle, group, solid, outlined)
import Text
import Color exposing (grey, black, white, green, red)

barWidth = 150
barHeight = 100

barsNumX = 4
barsNumY = 2

barsList = [0 .. barsNumX * barsNumY - 1]

semiquaverOffset : Int -> Float
semiquaverOffset sq = toFloat sq * barWidth / 16 - barWidth / 32

bars : Form
bars =
    let width = barWidth * barsNumX
        height = barHeight * barsNumY
    in [ rect 1 height |> filled black |> moveX -barWidth
       , rect 1 height |> filled black |> moveX  barWidth
       , rect 1 height |> filled black
       , rect width 1 |> filled black
       , rhythmDots
       ] |> group

chordNames : ChordProgression -> Form
chordNames =
    let f mm nq = uncurry nameOfRelativeChord nq
               |> Text.fromString
               |> text
               |> moveToTime mm 8
               |> moveY (barHeight / 8)
    in group << List.map2 f barsList << Array.toList

rhythmDots : Form
rhythmDots =
    let dot mm sq = circle 3
                 |> outlined (solid black)
                 |> moveToTime mm (sq + 2)
                 |> moveY (toFloat <| -barHeight // 4)
    in group
          << List.concat
          << flip   List.map          barsList
          <| \mm -> List.map (dot mm) [0, 4, 8, 12]

chordToPlay : Note -> ChordProgression -> Int -> Form
chordToPlay tonic prog mm =
    let idx = mm % (barsNumX * barsNumY)
        (num, qual) = case Array.get idx prog of
            Just x -> x
            Nothing -> (0, Maj)
        -- TODO(sandy): I'm not convinced this is the
        -- right expression to get the template
        template = getScaleTemplate Maj
        root = curry scaleNote tonic template num
        chord = (root, qual)
        chart =
            case TypedDict.get chord Chords.knownChords of
                Just x  -> x
                Nothing -> []
    in drawChordChart chart

moveToTime : Int -> Int -> Form -> Form
moveToTime mm sq = moveX (-barWidth * barsNumX / 2)
                >> moveY (barHeight / 2)
                >> moveX (semiquaverOffset sq)
                >> moveX (toFloat <| mm % barsNumX * barWidth)
                >> moveY (toFloat <| (mm // barsNumX) % barsNumY * -barHeight)

scrubber : Timing -> Form
scrubber time = rect 2 barHeight
             |> filled red
             |> moveToTime time.measure time.semiquaver



view : Viewport -> Timing -> Note -> ChordProgression -> Element
view viewport time tonic prog =
    collage (fst viewport) 200
        [ scrubber time
        , bars
        , chordNames prog
        , group [ fretboard
                , chordToPlay tonic prog time.measure
                ]
            |> moveX (barsNumX / 2 * barWidth)
            |> moveX 100
        ]

