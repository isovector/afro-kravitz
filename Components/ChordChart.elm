module Components.ChordChart (chordChart, chordChart') where

import Chords exposing (getChordChart)
import Types exposing (..)
import Utils exposing (return, ordinal)

import Color exposing (grey, black, white, green)
import Graphics.Collage exposing (Form (..), collage, toForm, text, filled, moveX, moveY, rect, circle, group)
import Graphics.Element exposing (Element, centered, leftAligned)
import Text exposing (Text (..), fromString, color)
import Random exposing (maxInt)

fretLabelWidth = 40
chartWidth = fretboardWidth + fretLabelWidth
fretboardWidth = 90
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

chordChart : Chord -> Element
chordChart c =
  case getChordChart c of
    Just chart -> chordChart' chart
    Nothing    -> centered << fromString <| toString c

chordChart' : ChordChart -> Element
chordChart' cc =
    let firstFret = getFirstFret cc
        startingFret =
            if firstFret > 4
               then firstFret
               else 1
        addFret delta fingering = case fingering of
            Finger f fret s    -> Finger f (fret + delta) s
            Barre f fret s1 s2 -> Barre f (fret + delta) s1 s2
        adjustedChart = List.map (addFret <| -startingFret + 1) cc
    in collage chartWidth chartHeight
        << ((::) <| fretboard startingFret)
        <| List.map drawFingering adjustedChart

getFirstFret : ChordChart -> Fret
getFirstFret =
    let getFret f = case f of
            Finger _ fret _  -> fret
            Barre _ fret _ _ -> fret
    in List.foldr min maxInt << List.map getFret

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
drawFingering fingering = moveX (-fretLabelWidth / 2) <|
  case fingering of
    Finger finger fret string -> drawFinger finger fret string
    Barre  finger fret str1 str2 -> drawBarre finger fret str1 str2

fretboard : Fret -> Form
fretboard firstFret =
    let makeString gs = rect (stringWidth gs) chartHeight
                     |> filled black
                     |> moveX (stringX gs)
        makeFret n =
            rect chartWidth (fretWidth <| firstFret + n - 1)
                |> filled white
                |> moveY (n |> toFloat >> fretY)
        fretLabel =
            if firstFret /= 1
               then ordinal firstFret
                    |> fromString
                    |> leftAligned
                    |> toForm
                    |> moveY (fretY 0.5)
                    |> moveX (fretboardWidth / 2)
                    |> moveX (fretLabelWidth / 2)
                    |> return
               else []
    in [ rect fretboardWidth chartHeight |> filled grey
       ] ++ fretLabel
         ++ List.map makeFret [0..4]
         ++ List.map makeString [1..6]
         |> group
         |> moveX (-fretLabelWidth / 2)
