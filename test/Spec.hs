import Control.Monad (forM_)
import PGNParser (parseField, splitGameStrings)
import Test.Hspec (describe, hspec, it, shouldBe, pendingWith)
import Data.List (intercalate)

testGame1 =
  "[Event \"Let's Play!\"]\n"
    ++ "[Site \"Chess.com\"]\n"
    ++ "[Date \"2020.11.25\"]\n"
    ++ "[Round \"-\"]\n"
    ++ "[White \"ignaciowillats\"]\n"
    ++ "[Black \"eoghancrowley\"]\n"
    ++ "[Result \"0-1\"]\n"
    ++ "[WhiteElo \"1001\"]\n"
    ++ "[BlackElo \"941\"]\n"
    ++ "[TimeControl \"1/432000\"]\n"
    ++ "[EndDate \"2020.11.27\"]\n"
    ++ "[Termination \"eoghancrowley won by resignation\"]\n"
    ++ "\n"
    ++ "1. d4 e6 2. Nf3 f5 3. Bf4 Nf6 4. e3 g6 5. Bd3 Ng4 6. h3 Nf6 7. Nc3 d6 8. Qe2 Nc6\n"
    ++ "9. O-O-O Nb4 10. a3 a5 11. axb4 axb4 12. Bb5+ c6 13. Ba4 bxc3 14. b3 Nd5 15. Qd3\n"
    ++ "Nb4 16. Qxc3 Na2+ 17. Kd2 Nxc3 18. Kxc3 b5 0-1\n"

testGame2 =
  "[Event \"Let's Play!\"]\n"
    ++ "[Site \"Chess.com\"]\n"
    ++ "[Date \"2020.11.27\"]\n"
    ++ "[Round \"-\"]\n"
    ++ "[White \"eoghancrowley\"]\n"
    ++ "[Black \"ignaciowillats\"]\n"
    ++ "[Result \"0-1\"]\n"
    ++ "[WhiteElo \"804\"]\n"
    ++ "[BlackElo \"1001\"]\n"
    ++ "[TimeControl \"1/432000\"]\n"
    ++ "[EndDate \"2020.12.01\"]\n"
    ++ "[Termination \"ignaciowillats won by checkmate\"]\n"
    ++ "\n"
    ++ "1. e4 e5 2. d4 Nc6 3. d5 Nd4 4. Nf3 Bc5 5. Nxe5 f6 6. Bf4 d6 7. Bb5+ Nxb5 8. Nf3\n"
    ++ "Bg4 9. O-O Qe7 10. Qd3 a6 11. a4 Bxf3 12. Qxf3 Nd4 13. Qe3 Nxc2 14. Qb3 Nxa1 15.\n"
    ++ "Qxb7 Qd8 16. Na3 Rb8 17. Qxa6 Rxb2 18. Qc6+ Qd7 19. Qa8+ Kf7 20. Nc4 Rb4 21.\n"
    ++ "Rxa1 Rxc4 22. a5 Rxe4 23. g3 Qe8 24. Qb7 Qd7 25. a6 Bd4 26. Rc1 Re2 27. a7 Bxf2+\n"
    ++ "28. Kf1 Bxa7 29. Kxe2 Bc5 30. Be3 Qe7 31. Rc3 Nh6 32. Kf3 g5 33. g4 f5 34. Bxg5\n"
    ++ "Qe4+ 35. Kg3 Qxg4# 0-1\n"

gameList1 = intercalate "\n" [testGame1, testGame2]
gameList2 = intercalate "\n" [testGame2, testGame1]

main :: IO ()
main = hspec $ do
  describe "PGNParser.parseField" $ do
    forM_
      [ ("[Event \"Let's Play!\"]", ("Event", "Let's Play!")),
        ("[Site \"Chess.com\"]", ("Site", "Chess.com")),
        ("[Date \"2020.11.27\"]", ("Date", "2020.11.27")),
        ("[Round \"-\"]", ("Round", "-")),
        ("[White \"eoghancrowley\"]", ("White", "eoghancrowley")),
        ("[Black \"ignaciowillats\"]", ("Black", "ignaciowillats")),
        ("[Result \"0-1\"]", ("Result", "0-1")),
        ("[WhiteElo \"804\"]", ("WhiteElo", "804")),
        ("[BlackElo \"1001\"]", ("BlackElo", "1001")),
        ("[TimeControl \"1/432000\"]", ("TimeControl", "1/432000")),
        ("[EndDate \"2020.12.01\"]", ("EndDate", "2020.12.01")),
        ("[Termination \"ignaciowillats won by checkmate\"]", ("Termination", "ignaciowillats won by checkmate"))
      ]
      $ \x ->
        it ("should return " ++ show (snd x) ++ " when handed " ++ show (fst x)) $
          parseField (fst x) `shouldBe` snd x
  describe "PGNParser.splitGameStrings" $ do
    it "should return 2 games from list" $
      splitGameStrings gameList1 `shouldBe` [testGame1, testGame2]
    it "should return 2 games from list" $
      splitGameStrings gameList2 `shouldBe` [testGame2, testGame1]

  describe "PGNParser.parseGame" $ do
    it "should parse game correctly" $
      pendingWith "Requires implementation"