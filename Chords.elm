module Chords where

import Types exposing (..)

a : Chord
a = [ Finger 1 2 3
    , Finger 2 2 4
    , Finger 3 2 2
    ]

am : Chord
am = [ Finger 1 1 2
     , Finger 2 2 4
     , Finger 3 2 3
     ]

bm : Chord
bm = [ Barre  1 2 5 1
     , Finger 2 3 2
     , Finger 3 4 3
     , Finger 4 4 4
     ]

c : Chord
c = [ Finger 1 1 2
    , Finger 2 2 4
    , Finger 3 3 5
    ]

d : Chord
d = [ Finger 1 2 3
    , Finger 2 2 1
    , Finger 3 3 2
    ]

dm : Chord
dm = [ Finger 1 1 1
     , Finger 2 2 3
     , Finger 3 3 2
     ]

e : Chord
e = [ Finger 1 1 3
    , Finger 2 2 5
    , Finger 3 2 4
    ]

em : Chord
em = [ Finger 2 2 5
     , Finger 3 2 4
     ]

g : Chord
g = [ Finger 1 2 5
    , Finger 2 3 6
    , Finger 3 3 1
    ]
