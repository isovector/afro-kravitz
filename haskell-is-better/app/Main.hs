module Main where

import Reflex.Dom

import Lib

main = mainWidget $ el "div" $ do
  t <- textInput def
  text "Last key pressed: "
  let keypressEvent = fmap show $ _textInput_keypress t
  keypressDyn <- holdDyn "None" keypressEvent
  dynText keypressDyn
