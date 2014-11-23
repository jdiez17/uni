module Main where

import MapReduce
import System.IO
import Data.Char
import Data.List (sortBy)

clean :: String -> String
clean s = [toLower c | c <- s, isAlpha c] 

main = do 
    print "Reading file..."
    contents <- readFile "mobydick.txt" 
    let w = map clean $ words contents

    print "Map-reducing..."
    let res = reverse $ sortBy (\a b -> compare (snd a) (snd b)) $ result w 

    print "Writing..."
    writeFile "mobydick-out.txt" $ show res

    print "Done."
