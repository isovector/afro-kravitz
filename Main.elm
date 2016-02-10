module Main where

import Graphics.Element exposing (Element, show)
import ChordViewer

type Page = ChordViewer | About

pageSignal : Signal Page
pageSignal = Signal.constant ChordViewer

main: Signal Element
main = 
    Signal.map (router >> viewNavbar) pageSignal

router : Page -> Element
router page = 
    case page of
        ChordViewer -> ChordViewer.view
        About -> show "Ariel and Sandy are ridiculously sexy beasts. haha hahaa" -- About.view

viewNavbar : Element -> Element
viewNavbar myspace =
    myspace