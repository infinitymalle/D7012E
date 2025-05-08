--3.7

threeDifferent :: Int -> Int -> Int -> Bool
threeDifferent a b c
    | a == b = False
    | b == c = False
    | a == c = False
    | otherwise = True

--3.8

fourEqual :: Int -> Int -> Int -> Int -> Bool
fourEqual a b c d 
    | a == b && b == c && c == d = True
    | otherwise = False

-- 3.15 

numberNDroots :: Float -> Float -> Float -> Int
numberNDroots a b c 
    | b^2 >  4.0*a*b = 2
    | b^2 == 4.0*a*b = 1
    | b^2 <  4.0*a*b = 0

-- 3.16

numberRoots :: Float -> Float -> Float -> Int
numberRoots a b c
    | b^2 >  4.0*a*b = 2
    | b^2 == 4.0*a*b = 1
    | b^2 <  4.0*a*b = 0
    | b == 0 && c == 0 = 3

-- 4.7

additionTheWierdWay :: Int -> Int -> Int
additionTheWierdWay a b
    | b == 0 = 0
    | otherwise = a + additionTheWierdWay a (b-1)

-- 4.9

--afunction :: (Int -> Int) -> Int -> Int
--afunction f x

-- 5.10

divisor :: Int -> [Int]
divisor x = [n | n <- [1..x], x `mod` n == 0]

isPrime :: Int -> Bool
isPrime x
    | divisor x == [1,x] = True
    | otherwise = False


-- 5.11

matches :: Int -> [Int] -> [Int]
matches x xs = [n | n <- xs, n == x]
--    | xs == [] = []w
--    | x == head xs = [head xs] + matches x tail xs

-- 7.2 with patternmatching

firstTwo :: [Int] -> Int
firstTwo [] = 0
firstTwo [x] = x
firstTwo [x, y, _] = x+y

-- 7.2 without patternmatching

firsttwo :: [Int] -> Int
firsttwo xs
    | length xs == 0 = 0
    | length xs == 1 = head xs
    | length xs >= 2 = xs !! 0 + xs !! 1

-- 7.4 

listProduct :: [Int] -> Int
listProduct xs
    | length xs == 0 = 1
    | length xs >= 1 = (xs !! 0) * product (tail xs)

-- 9.2

length2 :: [Int] -> Int
length2 xs = sum (map square xs)

square :: Int -> Int
square x = x*x


-- 9.9

iter :: Int -> (a -> a) -> a -> a
iter 0 _ x = x
iter n f x = f (iter (n-1) f x)

double :: Int -> Int
double x = x*2

-- 9.11

sumsquare :: Int -> Int
sumsquare n = foldr (+) 0 (map (\x -> x*x) [1..n])

-- 9.16

filterFirst :: (a -> Bool) -> [a] -> [a]
filterFirst _ [] = []
filterFirst p (x:xs)
    | p x = xs 
    | otherwise = x : filterFirst p xs

-- 9.17

filterLast :: (a -> Bool) -> [a] -> [a]
filterLast _ [] = []
filterLast p xs = reverse (filterFirst p (reverse xs))

-- 10.3

composeList :: [a -> a] -> (a -> a)
composeList = foldr (.) id

-- 10.14

printChessBoard:: Int -> IO()
printChessBoard n = putStr (chessBoard n n)

chessBoard :: Int -> Int -> String
chessBoard 0 m = ""
chessBoard n m 
    | mod n 2 == 0 = nsquares m ++ chessBoard (n-1) m
    | mod n 2 /= 0 = chessWhite ++ nsquares (m-1) ++ chessBoard (n-1) m
    

chessWhite :: String
chessWhite = "  "

chessBlack :: String
chessBlack = "##"

whiteBlack :: String
whiteBlack = chessWhite ++ chessBlack

blackWhite :: String
blackWhite = chessBlack ++ chessWhite

nsquares :: Int -> String
nsquares 0 = "\n"
nsquares 1 = chessBlack ++ "\n"
nsquares n = blackWhite ++ nsquares (n-2)

-- 12.2

numEquals :: Eq a => [a] -> a -> Int
numEquals [] _ = 0
numEquals (x:xs) y
    | x == y = numEquals xs y + 1
    | otherwise = numEquals xs y


-- 12.3

oneLookupFirst :: Eq a => [ (a,b) ] -> a -> b
oneLookupFirst [] _ = error "empty list"
oneLookupFirst (x:xs) y 
    | (fst x) == y = (snd x)
    | otherwise = oneLookupFirst xs y


--oneLookupSecond :: Eq a => [ (a,b) ] -> b -> a
--oneLookupSecond [] _ = error "empty list"
--oneLookupSecond (x:xs) y
--    | (snd x) == y = (fst x)
--    | otherwise = oneLookupSecond xs y

-- 12.5

