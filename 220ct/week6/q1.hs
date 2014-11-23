module Q1 where

import MapReduce

data Colour = R | G | B | O | P
    deriving (Show, Eq, Ord)

entries = [R, G, G, G, R, B, O, P, P, B, O, R, B, P, R, O]

main = putStrLn $ show $ result entries
