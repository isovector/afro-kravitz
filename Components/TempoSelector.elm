module Components.TempoSelector where

import Graphics.Input exposing (..)
import Graphics.Element exposing (..)

import App exposing (pageBox, Page (..))
import Types exposing (..)
import ScaleTemplates exposing (..)

tempoSelector : (Int -> a) -> Signal.Address a -> Int -> Element
tempoSelector f address bpm = 
    button (Signal.message address <| f <| bpm*2) "Tempo-job"