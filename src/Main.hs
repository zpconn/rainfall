{-# LANGUAGE CPP #-}

module Main where

import qualified Data.Map as Map
import           Data.Array
import           Control.Monad

-- Index type for our two-dimensional arrays.
type Loc = (Int, Int)
type Rainmap = Array Loc Int

main = do numLines <- getLine
          let rainMap = parseInput (read numLines) (read numLines)
          sizes <- liftM basinSizes $ rainMap
          print sizes

-- Breaks the input into tokens.
readWords :: (Read a) => String -> [a]
readWords = map read . words

-- Creates a two-dimensional array from the input.
parseInput :: Int -> Int -> IO Rainmap
parseInput rows cols = do
    matr <- liftM readWords $ getContents
    return $ listArray ((1, 1), (rows, cols)) matr

-- Computes the basin sizes.
basinSizes :: Rainmap -> [Int]
basinSizes arr = preImages (flowMap arr) (indices arr)

-- Maps a location in a map of rain levels to its destination sink.
flowMap :: Rainmap -> Loc -> Loc
flowMap arr start = if isSink arr start then start
                    else flowMap arr (minRain (neighbors arr start))

-- Takes a mapping f : a -> a of sets and produces a list of the sizes of the preimages
-- of elements of b in a.
preImages :: Ord a => (a -> a) -> [a] -> [Int]
preImages f source = preImages' f Map.empty source
    where preImages' f histogram []     = map snd $ Map.toList histogram
          preImages' f histogram (x:xs) = preImages' f histogram' xs
              where histogram' = if Map.member (f x) histogram then (Map.adjust (\y -> y + 1) (f x) histogram)
                                                               else Map.insert (f x) 1 histogram

-- Determines if a location in a map of rain levels is a sink.
isSink :: Rainmap -> Loc -> Bool
isSink arr e = let v = arr ! e in
               (minimum $ [v] ++ map snd (neighbors arr e)) == v

-- Creates a list of location-value pairs corresponding to the four neighbors of the
-- given element in the rain map.
neighbors :: Rainmap -> Loc -> [(Loc, Int)]
neighbors arr (x, y) =
    (if x == (fst $ fst $ bounds arr) then [] else [((x - 1, y    ), arr ! (x - 1, y    ))]) ++
    (if x == (fst $ snd $ bounds arr) then [] else [((x + 1, y    ), arr ! (x + 1, y    ))]) ++
    (if y == (snd $ fst $ bounds arr) then [] else [((x,     y - 1), arr ! (x,     y - 1))]) ++
    (if y == (snd $ snd $ bounds arr) then [] else [((x,     y + 1), arr ! (x,     y + 1))])

-- Determines the location of the minimum element of a list of location-value pairs.
minRain :: [(Loc, Int)] -> Loc
minRain lst = let m = minimum (map snd lst) in min' lst m
          where min' lst v = if (snd $ head lst) == v then fst $ head lst
                                                      else min' (tail lst) v
