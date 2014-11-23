module Week2 where

import Data.List     (transpose)
import Control.Arrow

data Piece = King | Queen | Rook | Bishop | Knight | Pawn | Empty
    deriving (Show)

data Board = Board Int Int [[Piece]]
instance Show Board where
    show (Board _ _ lst) = show lst

data Vec2 = Vec2 Int Int
    deriving (Show)

makeBoard :: Int -> Int -> Board
makeBoard x y = Board x y . replicate y . replicate x $ Empty

inBounds :: Vec2 -> Vec2 -> Bool
inBounds (Vec2 x y) (Vec2 x' y') =
    (x > x') && (x' >= 0) &&
    (y > y') && (y' >= 0)

pieceSees :: Board -> Piece -> (Vec2 -> [Vec2])
pieceSees (Board sx sy _) p = (filter $ inBounds (Vec2 sx sy)) . pieceFunc p
    where 
        pieceFunc Rook = \(Vec2 x y) -> 
            [Vec2 x y' | y' <- [0..sy]] ++
            [Vec2 x' y | x' <- [0..sx]]

        pieceFunc Knight = \(Vec2 x y) ->
            [Vec2 (x + dx) (y + dy) | [dx, dy] <- combos [[1, -1], [2, -2]]]
                where
                    combos xs = sequence xs ++ sequence (reverse xs)

        pieceFunc p = \_ -> [] -- Undefined
