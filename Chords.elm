module Chords where

import Typeclasses
import Types exposing (..)
import TypedDict exposing (..)


knownChords : Map (Note, Quality) ChordChart
knownChords = fromList (Typeclasses.liftOrd noteOrd qualityOrd)
    [ ((A, Maj), a)
    , ((A, Min), am)
    , ((B, Maj), b)
    , ((B, Min), bm)
    , ((C, Maj), c)
    , ((C, Min), cm)
    , ((D, Maj), d)
    , ((D, Min), dm)
    , ((E, Maj), e)
    , ((E, Min), em)
    , ((F, Maj), f)
    , ((F, Min), fm)
    , ((G, Maj), g)
    , ((G, Min), gm)
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

g : ChordChart
g = [ Finger 1 2 5
    , Finger 2 3 6
    , Finger 3 3 1
    ]

gm : ChordChart
gm = [ Barre 1 3 1 6
     , Finger 4 5 6
     , Finger 3 5 5
     ]
