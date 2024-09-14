import System.IO (readFile,writeFile)
pat :: Int -> String
pat n = unlines $ bottomRows ++ topRows
  where
    topRows = [spaces i ++ stars (n - 2 * i) | i <- [0..n `div` 2]]
    bottomRows = reverse [spaces i ++ stars (n - 2 * i) | i <- [1..n `div` 2]]
    stars x = replicate x '*'
    spaces x = replicate x ' '
main :: IO ()
main = do
    content <- readFile "input.txt"
    let n = read content :: Int
    
    if n `rem` 2==1
         then do
            let pattern = pat n
            writeFile "output.txt" pattern
    else putStrLn "Enter Odd"