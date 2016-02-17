module Components.ChordChart (chordChart) where

import Types exposing (..)
import Utils exposing (return)

import Color exposing (grey, black, white, green)
import Graphics.Collage exposing (Form (..), collage, toForm, text, filled, moveX, moveY, rect, circle, group)
import Graphics.Element exposing (Element)
import Text exposing (Text (..), fromString, color)

chartWidth = 90
chartHeight = 110

fingerColor = green
stringSpacing = 15
fretSpacing = 24
fingerRadius = 7

stringX : GString -> Float
stringX n = (6 - toFloat n - 2.5) * stringSpacing

stringWidth : GString -> Float
stringWidth n = toFloat n * 0.5

fretY : Float -> Float
fretY n = (n - 2) * -fretSpacing

fretWidth : Fret -> Float
fretWidth n = if n == 0 then 4 else 2

drawFinger : Int -> Fret -> GString -> Form
drawFinger f fret s =
    let circ = circle fingerRadius
            |> filled fingerColor
        num = toString f |> fromString |> text |> moveY 2
    in group [ circ, num ]
       |> moveX (stringX s)
       |> moveY (fretY (toFloat fret - 0.5))

drawBarre : Int -> Fret -> GString -> GString -> Form
drawBarre f fret n1 n2 =
    let first = min n1 n2
        second = max n1 n2
        firstX = stringX first
        secondX = stringX second
        width = secondX - firstX
        x = (firstX + secondX) / 2
        bar =
            [ rect width (fingerRadius * 2) |> filled fingerColor
            , toString f |> fromString |> text |> moveY 2
            ] |> group |> moveX x

    in [ circle fingerRadius |> filled fingerColor |> moveX (stringX first)
       , circle fingerRadius |> filled fingerColor |> moveX (stringX second)
       , bar
       ]
       |> group |> moveY (fretY (toFloat fret - 0.5))

drawFingering : Fingering -> Form
drawFingering fingering = case fingering of
    Finger finger fret string -> drawFinger finger fret string
    Barre  finger fret str1 str2 -> drawBarre finger fret str1 str2

fretboard : Form
fretboard =
    let makeString gs = rect (stringWidth gs) chartHeight
                     |> filled black
                     |> moveX (stringX gs)
        makeFret n = rect chartWidth (fretWidth n)
                  |> filled white
                  |> moveY (n |> toFloat >> fretY)
    in [ rect chartWidth chartHeight |> filled grey
       ] ++ List.map makeFret [0..4]
         ++ List.map makeString [1..6]
         |> group

chordChart : ChordChart -> Element
chordChart = collage chartWidth chartHeight
          << ((::) fretboard)
          << return
          << group
          << List.map drawFingering

