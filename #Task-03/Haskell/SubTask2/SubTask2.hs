import System.IO (readFile,writeFile)
main :: IO ()
main = do
    content <- readFile "input.txt"
    putStrLn content
    writeFile "output.txt" content
