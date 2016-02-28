module Components.TempoSelector where

import Graphics.Input.Field exposing (..)
import Graphics.Input exposing (..)
import Graphics.Element exposing (..)
import String exposing (toInt)

import App exposing (tempoBox, Page (..))
import Types exposing (..)
import ScaleTemplates exposing (..)

tempoSelector : Signal.Address a -> Content -> Element
tempoSelector address tempoContent = 
    field defaultStyle (\content -> Signal.message tempoBox.address content) "120" tempoContent

