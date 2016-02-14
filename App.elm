module App where

import Graphics.Element exposing (..)
import Graphics.Input exposing (..)

import Types exposing(..)
import Chords

type Page = About | ChordLibraryPage Chord

pageBox : Signal.Mailbox Page
pageBox =
    Signal.mailbox About

embedPageTemplate : Element -> Element
embedPageTemplate pageTemplate =
    let pageChangeBtn = button (Signal.message pageBox.address <| ChordLibraryPage Chords.a) "Push it baby"
    in flow down [pageTemplate, pageChangeBtn]