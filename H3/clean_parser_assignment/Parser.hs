module Parser(module CoreParser, T, digit, digitVal, chars, letter, err,
              lit, number, iter, accept, require, token,
              spaces, word, (-#), (#-)) where
import Prelude hiding (return, fail)
import Data.Char
import CoreParser
infixl 7 -#, #- 

type T a = Parser a

err :: String -> Parser a
err message cs = error (message++" near "++cs++"\n")

iter :: Parser a -> Parser [a]  
iter m = m # iter m >-> cons ! return [] 

cons(a, b) = a:b

(-#) :: Parser a -> Parser b -> Parser b
m -# n = m # n >-> snd --error "-# not implemented"

(#-) :: Parser a -> Parser b -> Parser a
m #- n = m # n >-> fst --error "#- not implemented"

spaces :: Parser String
spaces = iter (char ? isSpace) -- "require not implemented"

token :: Parser a -> Parser a
token m = m #- spaces 

letter :: Parser Char
letter = char ? isAlpha --"require not implemented"

word :: Parser String
word = token (letter # iter letter >-> cons)

chars :: Int -> Parser String
chars 0 = return ""
chars n = char # chars (n-1) >-> cons -- "require not implemented"

accept :: String -> Parser String
accept w = (token (chars (length w))) ? (==w)

require :: String -> Parser String
require w  = (token (chars (length w))) ? (==w) !  err ("Error in require with next parse element->" ++ w) -- "require not implemented"

lit :: Char -> Parser Char
lit c = token char ? (==c)

digit :: Parser Char 
digit = char ? isDigit 

digitVal :: Parser Integer
digitVal = digit >-> digitToInt >-> fromIntegral

number' :: Integer -> Parser Integer
number' n = digitVal #> (\ d -> number' (10*n+d))
          ! return n
number :: Parser Integer
number = token (digitVal #> number')

