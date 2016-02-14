module View where

import Types exposing (..)
import Model exposing (..)
import ChordDrawing exposing (..)

import Graphics.Element exposing (Element (..), height, left, beside, midBottom, rightAligned, show, flow, right, down, centered, spacer, container, middle)
import Graphics.Collage exposing (Form (..), collage, toForm, text, group)
import Graphics.Input.Field exposing (field, noContent, defaultStyle, Content)
import List exposing (concat, map)
import Array exposing (fromList, get, length, toList)
import Color exposing (red)
import Text exposing (Text (..), fromString, color)
import Timing exposing (bpmMailbox)

canvasWidth = 800
canvasHeight = 200

inputHeight = 20

render model chord content =
    let tempoInput = makeTempoInput content
    in flow down [ (fretboard :: List.map drawChordChart chord) |> collage canvasWidth canvasHeight
                 , tempoInput]

makeTempoInput : Content -> Element
makeTempoInput content  =
    let inputField = field defaultStyle (Signal.message bpmMailbox.address) "BPM" content
        label = Text.height inputHeight (fromString "Tempo: ") |> rightAligned
        layout = flow left (map (height inputHeight) [inputField, label])
    in container canvasWidth canvasHeight midBottom layout
