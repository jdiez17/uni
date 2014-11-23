module LinkedList where

data List a = End | Cons a (List a)
    deriving (Show, Eq)

head' :: List a -> a
head' (Cons x _) = x

tail' :: List a -> List a
tail' (Cons _ x) = x

delete :: (Eq a) => a -> List a -> List a
delete x xs
    | xs == End = End
    | head' xs == x = tail' xs
    | otherwise = Cons (head' xs) (delete x (tail' xs))

append :: a -> List a -> List a
append x (Cons x' End) = Cons x' (Cons x End)
append x xs = Cons (head' xs) $ append x (tail' xs)
