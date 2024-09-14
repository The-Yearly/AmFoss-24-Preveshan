pat :: Int -> IO ()
pat n = mapM_ putStrLn $  bottomRows ++ topRows
  where
    topRows = [spaces i ++ stars (n - 2 * i) | i <- [0..n `div` 2]]
    bottomRows = reverse [spaces i ++ stars (n - 2 * i) | i <- [1..n `div` 2]]
    stars x = replicate x '*'
    spaces x = replicate x ' '
main = do
    putStrLn "Enter N"
    input <- getLine
    let n = read input :: Int
    if n `rem` 2==1
        then pat n
    else putStrLn "Enter Odd"