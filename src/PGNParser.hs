module PGNParser where

import Data.List.Split
import Data.List (intercalate)

data ChessGame = ChessGame { 
  fooID :: Int, 
  moves :: [String] 
} deriving (Show)

getPGNTextFromFile :: String -> IO String
getPGNTextFromFile = readFile

parseField :: String -> (String, String)
parseField f =
  (cleanedFirstBit, secondBit)
  where
    bits = splitOn "\"" f
    firstBit = head bits
    secondBit = (head . tail) bits
    cleanedFirstBit = take (length firstBit - 2) (drop 1 firstBit)

splitGameStrings :: String -> [String]
splitGameStrings allGames = 
  mapBut1 lineBreak (map joinFunc gameParts)
  where
    splits = splitOn "\n\n" allGames
    gameParts = chunksOf 2 splits
    joinFunc x = intercalate "\n\n" x
    lineBreak x = x ++ "\n"

mapBut1 :: (a -> a) -> [a] -> [a]
mapBut1 f [] = []
mapBut1 f [x] = [x]
mapBut1 f (x:xs) = f x : mapBut1 f xs