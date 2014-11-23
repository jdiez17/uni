module Week7 where

-- Stack, op, new stack
evaluateOne :: [Double] -> String -> [Double]
evaluateOne xs op
    | op == "*" = next * top : xs'' 
    | op == "+" = next + top : xs''
    | op == "-" = next - top : xs''
    | op == "/" = next / top : xs''
    | otherwise = (read op :: Double) : xs
    where
        top = head xs 
        xs' = tail xs
        next = head xs'
        xs'' = tail xs'

-- Input string, resulting stack
doRPN :: String -> [Double]
doRPN input = foldl evaluateOne [] $ words input
