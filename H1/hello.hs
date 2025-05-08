
main = print (prime 17)

square :: Int -> Int
square x = x * x

func :: Int -> Int
func x = x + x



divisors :: Int -> [Int]
divisors a = [x | x <- [1..a], a `mod` x == 0]

prime :: Int -> Bool
prime x = divisors x == [1, x]


matches :: Int -> [Int] -> [Int]
matches _ [] = []
matches a (x:xs)
    | a == x = x : matches a xs
    | otherwise = matches a xs

onSeparateLines :: [String] -> String
onSeparateLines [] = ""
onSeparateLines (x:xs)  = x ++ "\n" ++ onSeparateLines xs

existsX :: Int -> [Int] -> Bool 
existsX _ [] = False
existsX a (x:xs) 
    | a == x = True
    | otherwise = existsX a xs

product1 :: [Int] -> Int
product1 [] = 1
product1 x = foldr (*) 1 x

unique :: [Int] -> [Int]
unique [] = []
unique (x:xs) = x : unique(remover x xs)

remover :: Int -> [Int] -> [Int]
remover _ [] = []
remover a (x:xs)
    | a == x = remover a xs 
    | otherwise = x : remover a xs



