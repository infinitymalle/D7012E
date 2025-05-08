smallestKset :: [Int] -> Int -> IO()
smallestKset [] _ = error "empty list"
smallestKset xs k = putStr ("size\t" ++ "i\t" ++ "j\t" ++ "sublist\n" ++
    printResult (myProgram xs) k)

printResult :: [(Int, Int, Int, [Int])] -> Int -> String
printResult [] _ = ""
printResult _ 0 = ""
printResult ((a, b, c, list):xs) x = 
    show a ++ "\t" ++ 
    show (b+1) ++ "\t" ++
    show (c+1) ++ "\t" ++
    show list ++ "\n" ++ 
    printResult xs (x-1)


myProgram :: [Int] -> [(Int, Int, Int, [Int])]
myProgram xs =  quickSort (calculateAllSublists xs)

quickSort :: [(Int, Int, Int, [Int])] -> [(Int, Int, Int, [Int])]
quickSort [] = []
quickSort (x:xs) =
  let smaller = quickSort [y | y <- xs, fst4 y <= fst4 x]
      bigger  = quickSort [y | y <- xs, fst4 y >  fst4 x]
  in smaller ++ [x] ++ bigger

-- Helper to extract first value of the tuple
fst4 :: (a, b, c, d) -> a
fst4 (x, _, _, _) = x


calculateAllSublists :: [Int] -> [(Int, Int, Int, [Int])]
calculateAllSublists xs = iteri xs 0 (length xs)

iteri :: [Int] -> Int -> Int -> [(Int, Int, Int, [Int])]
iteri _ i len
  | i >= len = []
iteri xs i len =
  iterj xs i i len ++ iteri xs (i + 1) len

iterj :: [Int] -> Int -> Int -> Int -> [(Int, Int, Int, [Int])]
iterj xs i j len
  | j >= len = []
  | otherwise =
      let sub = take (j - i + 1) (drop i xs)
      in (sum sub, i, j, sub) : iterj xs i (j + 1) len


    