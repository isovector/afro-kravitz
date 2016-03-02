module App where

import Graphics.Element exposing (..)
import Graphics.Input exposing (..)
import Graphics.Input.Field exposing (..)
import ScaleTemplates exposing (..)
import Time exposing (..)

import Types exposing(..)

type Page = About
          | ChordLibrary Chord
          | PlayAlong Note ChordProgression

pageBox : Signal.Mailbox Page
pageBox =
    Signal.mailbox <| PlayAlong C chordProgression

tempoBox : Signal.Mailbox Content
tempoBox = 
    Signal.mailbox { string = "120", selection = {start = 0, end = 0, direction =  Forward}}

pageSignal : Signal (Time, Page)
pageSignal = timestamp pageBox.signal

embedPageTemplate : Element -> Element
embedPageTemplate pageTemplate =
    let playAlongBtn = flip button "Play Along"
                     << Signal.message pageBox.address
                     <| PlayAlong G chordProgression
        chordLibBtn = flip button "Chord Library"
                      << Signal.message pageBox.address
                      <| ChordLibrary (C, Maj)
    in flow down [pageTemplate, playAlongBtn, chordLibBtn]
