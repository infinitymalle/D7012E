import Distribution.Backpack.FullUnitId (FullUnitId)

smallestKset :: [Int] -> Int -> IO ()
smallestKset x k = putStr ("Sum\ti\tj\tsubList\n" ++
    printResult (smallestSublist x) k)
    --smallestKset [x*(-1)^x | x <- [1..100]] 15
    --smallestKset [24, -11, -34,42,-24,7,-19,21] 6
    --smallestKset [3,2,-4,3,2,-5,-2,2,3,-3,2,-5,6,-2,2,3] 8

printResult :: [(Int, Int, Int, [Int])] -> Int -> String
printResult [] _ = ""
printResult ((a, b, c, d):xs) x
    | x == 0 = ""
    | otherwise =
        show a ++ "\t" ++ 
        show (b + 1) ++ "\t" ++ 
        show (c + 1) ++ "\t" ++ 
        show d ++ "\n" ++ printResult xs (x-1)

smallestSublist :: [Int] -> [(Int, Int, Int, [Int])]
smallestSublist [] = []
smallestSublist list = quickSort(itrSubLists list)-- confusing as fuck

itrSubLists :: [Int] -> [(Int, Int, Int, [Int])]
itrSubLists list = [(listSum (sublist i j), i, j, sublist i j ) | i <- [0..length list - 1], j <- [i..length list - 1]]
    where 
        sublist i j = take (j - i + 1) $ drop i list

listSum :: [Int] -> Int
listSum =  foldr (+) 0 

quickSort :: [(Int, Int, Int, [Int])] -> [(Int, Int, Int, [Int] )]
quickSort [] = []
quickSort ((a, b, c, d):xs) = 
    let smallerOrEqual = [(x, y, z, w) | (x, y, z, w) <- xs, x <= a]
        larger = [(x, y, z, w) | (x, y, z, w) <- xs, x > a]
    in quickSort smallerOrEqual ++ [(a, b, c, d)] ++ quickSort larger