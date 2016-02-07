module View where

import Types exposing (..)
import Model exposing (..)

import Graphics.Element exposing (Element (..), height, left, beside, midBottom, rightAligned, show, flow, right, down, centered, spacer, container, middle)
import Graphics.Collage exposing (Form (..), collage, toForm, text)
import Graphics.Input.Field exposing (field, noContent, defaultStyle, Direction (Forward), Content)
import ParseInt exposing (parseInt)
import List exposing (concat, map)
import Array exposing (fromList, get, length, toList)
import Color exposing (red)
import Text exposing (Text (..), fromString, color)

canvasWidth = 800
canvasHeight = 200

inputHeight = 20

view : Signal.Address Action -> Model -> Content -> Element
view address model content = (view2 address model) (showUi content)

view2 : Signal.Address Action -> Model -> Element -> Element
view2 address model bpmInput =
    flow down [viewChords model, bpmInput]
    
bpmMailbox : Signal.Mailbox Content
bpmMailbox = Signal.mailbox noContent    
 
showUi : Content -> Element
showUi content  = 
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
    
redText : Int -> Tone -> List Element
redText index chord =
    let selected = get index tones
        isSelected = Just chord == selected
        styling = if isSelected then color red else identity
        label = toString chord |> fromString |> styling |> centered
    in [label, spacer 10 1]

viewChords : Model -> Element
viewChords (index, time) =
    let layout = flow right (toList (Array.map (\tone -> redText index tone) tones) |> concat)
    in [toForm layout] |> collage canvasWidth canvasHeight