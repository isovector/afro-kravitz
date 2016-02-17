module Components.KeySelector where

import Types exposing (Note (..), noteEnum)
import Graphics.Input exposing (button)
import Graphics.Element exposing (Element, flow, right)

keySelector : (Note -> a) -> Signal.Address a -> Element
keySelector f address = flow right
                     << flip List.map noteEnum.elems
                     <| \note ->
                         button (Signal.message address <| f note)
                         <| toString note

