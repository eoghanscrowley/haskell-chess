module Main where

import Lib (someFunc)
import System.Directory

main :: IO ()
main = do
  directoryList <- listDirectory "."
  print directoryList
