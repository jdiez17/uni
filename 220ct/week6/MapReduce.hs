module MapReduce where

import Data.List (groupBy, sortBy)

count :: a -> (a, Int)
count x = (x, 1)

sort :: (Ord a) => [(a, b)] -> [(a, b)]
sort = sortBy (\a b -> compare (fst a) (fst b))

group :: (Eq a) => [(a, b)] -> [[(a, b)]]
group = groupBy (\a b -> fst a == fst b)

reduce :: [(a, Int)] -> (a, Int)
reduce list = (fst $ head list, foldr (\x count -> count + snd x) 0 list)

result xs = map reduce $ group $ sort $ map count xs
