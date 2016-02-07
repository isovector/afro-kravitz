module ChordDrawing
    ( fretboard
    ) where

import Types exposing (..)

import Graphics.Collage exposing (Form (..), collage, toForm, text, filled, moveX, moveY, rect, circle, group)
import Color exposing (grey, black, white, green)
import Text exposing (Text (..), fromString, color)


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

fretWidth : Int -> Float
fretWidth n = if n == 0 then 4 else 2

fingerCircle : Int -> Int -> GString -> Form
fingerCircle f fret s =
    let circ = circle fingerRadius
            |> filled fingerColor
        num = toString f |> fromString |> text |> moveY 2
    in group [ circ, num ]
       |> moveX (stringX s)
       |> moveY (fretY (toFloat fret - 0.5))

barre : Int -> Int -> GString -> GString -> Form
barre f fret n1 n2 =
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

fretboard : Form
fretboard =
    let width = 90
        height = 110
        makeString gs = rect (stringWidth gs) height
                     |> filled black
                     |> moveX (stringX gs)
        makeFret n = rect width (fretWidth n)
                  |> filled white
                  |> moveY (n |> toFloat >> fretY)
    in [ rect width height |> filled grey
       ] ++ List.map makeFret [0..4]
         ++ List.map makeString [1..6]
         ++ [ barre 1 2 5 1
            , fingerCircle 2 3 2
            , fingerCircle 3 4 3
            , fingerCircle 4 4 4
            ] |> group

