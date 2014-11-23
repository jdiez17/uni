module Week2 where

import Data.Char (digitToInt, isDigit)
import Data.List (intercalate)

splitName :: Int -> String -> [String]
splitName _ "" = []
splitName length name = [take length name] ++ splitName length (drop length name)

findDigit :: String -> Int
findDigit username = digitToInt $ if length digitsInUsername == 0 then '1' else head digitsInUsername
    where
        digitsInUsername = filter isDigit username

main = do
    putStrLn "gimme your name"
    name <- getLine
    putStrLn "gimme your user name"
    sid <- getLine
    let length = findDigit sid 
    putStrLn $ intercalate "\n" $ splitName length name
