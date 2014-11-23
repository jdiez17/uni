module Subleq where

import Control.Monad.State

data SubleqState = SubleqState { pc :: Int, memory :: [Int] }
    deriving (Show)

type Instruction = (Int, Int, Int)

execSubleq :: Instruction -> State SubleqState [Int]
execSubleq (a, b, c) = return [1] 

startState = SubleqState 0 $ replicate 1000 0

