module View where

import Types exposing (..)
import Model exposing (..)
import ChordDrawing exposing (..)

import Graphics.Element exposing (Element (..), height, left, beside, midBottom, rightAligned, show, flow, right, down, centered, spacer, container, middle)
import Graphics.Collage exposing (Form (..), collage, toForm, text, group)
import Graphics.Input.Field exposing (field, noContent, defaultStyle, Content)
import ParseInt exposing (parseInt)
import List exposing (concat, map)
import Array exposing (fromList, get, length, toList)
import Color exposing (red)
import Text exposing (Text (..), fromString, color)

canvasWidth = 800
canvasHeight = 200

inputHeight = 20

render : Signal.Address Action -> Model -> Content -> Element
render address model content =
    let tempoInput = makeTempoInput content
        chordDisplay = makeChordDisplay model
    in flow down [chordDisplay, tempoInput]
    
redText : Int -> Tone -> List Element
redText index chord =
    let selected = get index tones
        isSelected = Just chord == selected
        styling = if isSelected then color red else identity
        label = toString chord |> fromString |> styling |> centered
    in [label, spacer 10 1]

makeChordDisplay : Model -> Element
makeChordDisplay model =
    let toneLayout = flow right (toList (Array.map (\tone -> redText model.toneIndex tone) tones) |> concat)
    in [fretboard, drawChord cChord, toForm toneLayout] |> collage canvasWidth canvasHeight

bpmMailbox : Signal.Mailbox Content
bpmMailbox = Signal.mailbox noContent

makeTempoInput : Content -> Element
makeTempoInput content  =
    let inputField = field defaultStyle (Signal.message bpmMailbox.address) "BPM" content
        label = Text.height inputHeight (fromString "Tempo: ") |> rightAligned
        layout = flow left (map (height inputHeight) [inputField, label])
    in container canvasWidth canvasHeight midBottom layout

bpmSignal : Signal Int
bpmSignal = let onBpmChange s = (case parseInt s.string of
                Ok newBpm -> newBpm
                Err _     -> 1
            )
            in Signal.map onBpmChange bpmMailbox.signal
