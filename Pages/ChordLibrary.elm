module Pages.ChordLibrary (view) where

import App exposing (Page (ChordLibrary), pageBox)
import Components.ChordButton
import Components.ChordChart exposing (chordChart)
import Chords
import TypedDict exposing (toList, keys)
import Types exposing (..)

import Graphics.Element exposing (..)
import Graphics.Collage exposing (collage, toForm)
import List exposing (map)

chordList : List Chord
chordList = keys Chords.knownChords

view : Viewport -> Chord -> Signal.Address App.Page -> Element
view viewport chord address =
    let width = fst viewport
        height = (snd viewport) // 2
        chordButtonView = Components.ChordButton.view ChordLibrary pageBox.address
        chordButtonViews = flow right <| map chordButtonView chordList
        layout = container width 200 middle 
        chordButtonListView = layout chordButtonViews
        activeChordView = layout <| chordChart chord
        page = flow down [activeChordView, chordButtonListView]
    in collage width height [toForm page]

