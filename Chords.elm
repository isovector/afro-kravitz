module Chords where

import Typeclasses
import Types exposing (..)
import TypedDict exposing (..)


getChordChart : Chord -> Maybe ChordChart
getChordChart = flip get knownChords

knownChords : Map Chord ChordChart
knownChords = fromList chordOrd
    [ ((A, Maj), a)
    , ((A, Min), am)
    , ((A', Maj), a')
    , ((A', Min), a'm)
    , ((B, Maj), b)
    , ((B, Min), bm)
    , ((C, Maj), c)
    , ((C, Min), cm)
    , ((C', Maj), c')
    , ((C', Min), c'm)
    , ((D, Maj), d)
    , ((D, Min), dm)
    , ((D', Maj), d')
    , ((D', Min), d'm)
    , ((E, Maj), e)
    , ((E, Min), em)
    , ((F, Maj), f)
    , ((F, Min), fm)
    , ((F', Maj), f')
    , ((F', Min), f'm)
    , ((G, Maj), g)
    , ((G, Min), gm)
    , ((G', Maj), g')
    , ((G', Min), g'm)
    ]

a : ChordChart
a = [ Finger 1 2 3
    , Finger 2 2 4
    , Finger 3 2 2
    ]

am : ChordChart
am = [ Finger 1 1 2
     , Finger 2 2 4
     , Finger 3 2 3
     ]

a' : ChordChart
a' = [ Barre 1 1 5 1
     , Barre 3 3 4 2
     ]

a'm : ChordChart
a'm = [ Barre 1 1 5 1
      , Finger 4 3 4
      , Finger 3 3 3
      , Finger 2 2 5
      ]

b : ChordChart
b = [ Barre 1 2 5 1
    , Barre 3 4 4 2]

bm : ChordChart
bm = [ Barre  1 2 5 1
     , Finger 2 3 2
     , Finger 3 4 3
     , Finger 4 4 4
     ]

c : ChordChart
c = [ Finger 1 1 2
    , Finger 2 2 4
    , Finger 3 3 5
    ]

cm : ChordChart
cm = [ Barre 1 3 5 1
     , Finger 2 5 4
     , Finger 3 5 3
     , Finger 4 4 2
     ]

c' : ChordChart
c' = [ Barre 1 4 5 1
     , Barre 3 6 4 2]

c'm : ChordChart
c'm = [ Barre 1 4 5 1
     , Finger 2 6 4
     , Finger 3 6 3
     , Finger 4 5 2
     ]

d : ChordChart
d = [ Finger 1 2 3
    , Finger 2 2 1
    , Finger 3 3 2
    ]

dm : ChordChart
dm = [ Finger 1 1 1
     , Finger 2 2 3
     , Finger 3 3 2
     ]

d' : ChordChart
d' = [ Barre 1 6 5 1
     , Barre 3 8 4 2]

d'm : ChordChart
d'm = [ Barre 1 6 5 1
     , Finger 2 8 4
     , Finger 3 8 3
     , Finger 4 7 2
     ]

e : ChordChart
e = [ Finger 1 1 3
    , Finger 2 2 5
    , Finger 3 2 4
    ]

em : ChordChart
em = [ Finger 2 2 5
     , Finger 3 2 4
     ]

f : ChordChart
f = [ Barre 1 1 1 6
    , Finger 4 3 6
    , Finger 3 3 5
    , Finger 2 2 4
    ]

fm : ChordChart
fm = [ Barre 1 1 1 6
     , Finger 4 3 6
     , Finger 3 3 5
     ]

f' : ChordChart
f' = [ Barre 1 2 1 6
    , Finger 4 4 6
    , Finger 3 4 5
    , Finger 2 3 4
    ]

f'm : ChordChart
f'm = [ Barre 1 2 1 6
     , Finger 4 4 6
     , Finger 3 4 5
     ]

g : ChordChart
g = [ Finger 3 3 6
    , Finger 2 2 5
    , Finger 4 3 1
    ]

gm : ChordChart
gm = [ Barre 1 3 1 6
     , Finger 4 5 6
     , Finger 3 5 5
     ]

g' : ChordChart
g' = [ Barre 1 4 1 6
     , Finger 4 6 6
     , Finger 3 6 5
     , Finger 2 5 4
     ]

g'm : ChordChart
g'm = [ Barre 1 4 1 6
      , Finger 4 6 6
      , Finger 3 6 5
      ]
