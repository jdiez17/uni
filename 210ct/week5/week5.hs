module Week5 where

-- List of numbers, lower bound, upper bound
search :: [Int] -> Int -> Int -> Maybe Int

search [] _ _ = Nothing
search (x:xs) l u
    | x > l && x < u = Just x
    | otherwise      = search xs l u

-- Sorted list of numbers, lower bound, upper bound, mid

search' :: [Int] -> Int -> Int -> Maybe Int
search' xs l u = binSearch' xs l u 0 $ (length xs) - 1

binSearch' :: [Int] -> Int -> Int -> Int -> Int -> Maybe Int
binSearch' xs lower upper left right
    | x > lower && x < upper = Just x                                    -- Return
    | left == right          = Nothing                                   -- None found
    | x >= upper             = binSearch' xs lower upper left (mid - 1)  -- Move left
    | x <= lower             = binSearch' xs lower upper (mid + 1) right -- Move right

    where
        mid = (left + right) `div` 2
        x   = xs !! mid
