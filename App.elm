module App where

import Graphics.Element exposing (..)
import Graphics.Input exposing (..)
import ScaleTemplates exposing (..)
import Time exposing (..)

import Types exposing(..)

type Page = About
          | ChordLibrary Chord
          | PlayAlong Note ChordProgression Int

pageBox : Signal.Mailbox Page
pageBox =
    Signal.mailbox (PlayAlong C chordProgression 120)

pageSignal : Signal (Time, Page)
pageSignal = timestamp pageBox.signal

embedPageTemplate : Element -> Element
embedPageTemplate pageTemplate =
    let playAlongBtn = flip button "Play Along"
                     << Signal.message pageBox.address
                     <| PlayAlong G chordProgression 120
        chordLibBtn = flip button "Chord Library"
                      << Signal.message pageBox.address
                      <| ChordLibrary (C, Maj)
    in flow down [pageTemplate, playAlongBtn, chordLibBtn]
