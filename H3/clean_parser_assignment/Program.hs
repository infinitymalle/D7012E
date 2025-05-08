module Program(T, parse, fromString, toString, exec) where
import Parser hiding (T)
import qualified Statement
import qualified Dictionary
import Prelude hiding (return, fail)
newtype T = Program [Statement.T] deriving Show-- to be defined
instance Parse T where
  parse = iter parse >-> Program --error "Program.parse not implemented"
  toString (Program stmts)= concatMap Statement.toString stmts --error "Program.toString not implemented"

exec :: T -> [Integer] -> [Integer]
exec (Program stmts) = Statement.exec stmts Dictionary.empty --error "Program.exec not implemented"
