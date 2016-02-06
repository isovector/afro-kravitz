module View where

import Types exposing (..)
import Model exposing (..)

import Graphics.Element exposing (Element (..), show, flow, right, down, centered, spacer, container, middle)
import Graphics.Collage exposing (Form (..), collage, toForm, text)
import Graphics.Input.Field exposing (field, noContent, defaultStyle, Direction (Forward), Content)
import ParseInt exposing (parseInt)
import List exposing (concat)
import Array exposing (fromList, get, length, map, toList)
import Color exposing (red)
import Text exposing (Text (..), fromString, color)

canvasWidth = 800
canvasHeight = 200

view : Signal.Address Action -> Model -> Content -> Element
view address model content = (view2 address model) (showUi content)

view2 : Signal.Address Action -> Model -> Element -> Element
view2 address model bpmInput =
    flow down [viewChords model, bpmInput]
    
bpmMailbox : Signal.Mailbox Content
bpmMailbox = Signal.mailbox noContent    
 
showUi : Content -> Element
showUi content  = 
    container canvasWidth canvasHeight middle (field defaultStyle (Signal.message bpmMailbox.address) "BPM" content)
    
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
    let layout = flow right (toList (map (\tone -> redText index tone) tones) |> concat)
    in [toForm layout] |> collage canvasWidth canvasHeight