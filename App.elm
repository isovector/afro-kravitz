module App where

import Graphics.Element exposing (..)
import Graphics.Input exposing (..)
import ScaleTemplates exposing (..)
import Time exposing (..)

import Types exposing(..)
import Chords

type Page = About
          | ChordLibraryPage ChordChart
          | PlayAlong Note ChordProgression

pageBox : Signal.Mailbox Page
pageBox =
    Signal.mailbox (PlayAlong A chordProgression)

pageSignal : Signal (Time, Page)
pageSignal = timestamp pageBox.signal

embedPageTemplate : Element -> Element
embedPageTemplate pageTemplate =
    let pageChangeBtn = flip button "Push it baby"
                     << Signal.message pageBox.address
                     <| PlayAlong A chordProgression
    in flow down [pageTemplate, pageChangeBtn]
