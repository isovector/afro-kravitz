module Components.TempoSelector where

import Graphics.Input.Field exposing (..)
import Graphics.Input exposing (..)
import Graphics.Element exposing (..)
import String exposing (toInt)

import App exposing (tempoBox, Page (..))
import Types exposing (..)
import ScaleTemplates exposing (..)

tempoSelector : Signal.Address Content -> Content -> Element
tempoSelector address tempoContent = 
    field defaultStyle (Signal.message tempoBox.address) "120" tempoContent

