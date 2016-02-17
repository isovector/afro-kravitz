module Pages.PlayAlong where

import App exposing (pageBox)
import ChordDrawing exposing (drawChordChart, fretboard)
import Chords
import Components.KeySelector exposing (keySelector)
import KeyUtils exposing (nameOfRelativeChord, scaleNote)
import ScaleTemplates exposing (getScaleTemplate)
import Timing exposing (Timing)
import TypedDict exposing (get)
import Types exposing (..)

import Array
import Color exposing (grey, black, white, green, red)
import Graphics.Collage exposing
    ( Form (..)
    , circle
    , collage
    , filled
    , group
    , moveX
    , moveY
    , outlined
    , rect
    , solid
    , text
    , toForm
    )
import Graphics.Element exposing (Element, flow, down)
import Text exposing (fromString)

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
    let f meas nq = uncurry nameOfRelativeChord nq
                 |> fromString
                 |> text
                 |> moveToTime meas 8
                 |> moveY (barHeight / 8)
    in group << List.map2 f barsList << Array.toList

rhythmDots : Form
rhythmDots =
    let dot meas sq = circle 3
                 |> outlined (solid black)
                 |> moveToTime meas (sq + 2)
                 |> moveY (toFloat <| -barHeight // 4)
    in group
          << List.concat
          << flip     List.map            barsList
          <| \meas -> List.map (dot meas) [0, 4, 8, 12]

chordToPlay : Note -> ChordProgression -> Int -> Form
chordToPlay tonic prog meas =
    let idx = meas % (barsNumX * barsNumY)
        (num, qual) = case Array.get idx prog of
            Just x -> x
            Nothing -> (0, Maj)
        template = getScaleTemplate Maj
        root = curry scaleNote tonic template num
        chord = (root, qual)
        chart = case get chord Chords.knownChords of
            Just x  -> x
            Nothing -> []
    in drawChordChart chart

moveToTime : Int -> Int -> Form -> Form
moveToTime meas sq = moveX (-barWidth * barsNumX / 2)
                  >> moveY (barHeight / 2)
                  >> moveX (semiquaverOffset sq)
                  >> moveX (toFloat <| meas % barsNumX * barWidth)
                  >> moveY
                    (toFloat <| (meas // barsNumX) % barsNumY * -barHeight)

scrubber : Timing -> Form
scrubber time = rect 2 barHeight
             |> filled red
             |> moveToTime time.measure time.semiquaver

view : Viewport -> Timing -> Note -> ChordProgression -> Element
view viewport time tonic prog =
    flow down
        [ collage (fst viewport) 200
            [ scrubber time
            , bars
            , chordNames prog
            , group [ fretboard
                    , chordToPlay tonic prog time.measure
                    ]
                |> moveX (barsNumX / 2 * barWidth)
                |> moveX 100
            ]
        , keySelector (flip App.PlayAlong prog) pageBox.address
        ]

