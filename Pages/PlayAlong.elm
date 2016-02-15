module Pages.PlayAlong where

import List
import Types exposing (..)
import ChordDrawing exposing (drawChordChart, fretboard)
import Graphics.Element exposing (..)
import Timing exposing (..)

import Graphics.Collage exposing (Form (..), collage, toForm, text, filled, moveX, moveY, rect, circle, group, solid, outlined)
import Color exposing (grey, black, white, green, red)

barWidth = 150
barHeight = 100

barsNumX = 4
barsNumY = 2

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

rhythmDots : Form
rhythmDots =
    let dot mm sq = circle 3
                 |> outlined (solid black)
                 |> moveToTime mm (sq - 1)
    in group
          << List.concat
          << flip   List.map          [0 .. barsNumX * barsNumY - 1]
          <| \mm -> List.map (dot mm) [4, 8, 12, 16]



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
view viewport time note prog =
    collage 600 200 [ scrubber time, bars ]

