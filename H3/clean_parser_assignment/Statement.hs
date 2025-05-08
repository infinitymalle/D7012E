module Statement(T, parse, toString, fromString, exec) where
import Prelude hiding (return, fail)
import Parser hiding (T)
import qualified Dictionary
import qualified Expr
type T = Statement
data Statement =
    Assignment String Expr.T |
    Skip |
    Begin [Statement] | 
    If Expr.T Statement Statement|
    While Expr.T Statement | 
    Read String |
    Write Expr.T |
    Repeat Statement Expr.T
    deriving Show

assignment = word #- accept ":=" # Expr.parse #- require ";" >-> buildAss
buildAss (v, e) = Assignment v e

parseSkip = accept "skip" #- require ";" >-> buildSkip
buildSkip _ = Skip

parseBegin = accept "begin" -# iter parse #- require "end" >-> buildBegin
buildBegin = Begin 

parseIf = accept "if" -# Expr.parse #- require "then" # parse #- require "else" # parse >-> buildIf
buildIf ((cond, stmt1), stmt2) = If cond stmt1 stmt2

parseWhile = accept "while" -# Expr.parse #- require "do" # parse >-> buildWhile
buildWhile (cond, stmt) = While cond stmt

parseRead = accept "read" -# word #- require ";" >-> buildRead
buildRead = Read 

parseWrite = accept "write" -# Expr.parse #- require ";" >-> buildWrite
buildWrite = Write 

parseRepeat = (accept "repeat" -# parse #- require "until") # Expr.parse #- require ";" >-> buildRepeat
buildRepeat (stmts, cond) = Repeat stmts cond

exec :: [T] -> Dictionary.T String Integer -> [Integer] -> [Integer]
exec [] _ _ = []
exec (Assignment var expr : stmt) dict input =
  exec stmt newdict input
  where val = Expr.value expr dict
        newdict = Dictionary.insert (var, val) dict

exec (If cond thenStmts elseStmts: stmts) dict input = 
    if (Expr.value cond dict)>0 
    then exec (thenStmts: stmts) dict input
    else exec (elseStmts: stmts) dict input

exec (While cond doStmt:stmts) dict input = 
    if (Expr.value cond dict)>0 
    then exec (doStmt: While cond doStmt: stmts) dict input
    else exec (stmts) dict input

exec (Skip:stmts) dict input = 
    exec stmts dict input

exec (Begin stmtList:stmts) dict input = 
    exec (stmtList ++ stmts) dict input

exec (Read var :stmts) dict (input:s) = 
    exec stmts newdict s -- s the rest of the inputs
    where newdict = Dictionary.insert (var,input) dict

exec (Write expr :stmts) dict input =
    Expr.value expr dict : exec stmts dict input

exec (Repeat stmt cond:stmts) dict input =
    if (Expr.value cond dict)<1 then 
        exec (stmt:Repeat stmt cond:stmts)  dict input
    else 
        exec (stmt:stmts) dict input

instance Parse Statement where
    parse = assignment !
        parseIf !
        parseWhile !
        parseSkip !
        parseBegin !
        parseRead !
        parseWrite !
        parseRepeat
          --error "Statement.parse not implemented"
    toString = statementToString --error "Statement.toString not implemented"

statementToString :: Statement -> String
statementToString (Assignment var expr) =
     var ++ " =: " ++ Expr.toString expr ++ ";\n"
statementToString (If cond thenstmt elsestmt) =
    "if " ++ Expr.toString cond ++ " then\n" ++ 
    statementToString thenstmt ++ "else\n" ++
    statementToString elsestmt
statementToString (While cond dostmt) =
    "while " ++ Expr.toString cond ++ 
    " do\n" ++ statementToString dostmt
statementToString (Skip) =
    "skip;\n"
statementToString (Begin stmts) =
    "begin\n" ++ 
    concatMap statementToString stmts 
    ++ "end" ++ "\n"
statementToString (Read var) =
    "read " ++ var ++ ";\n"
statementToString (Write expr) =
    "write " ++ Expr.toString expr ++ ";\n"
statementToString (Repeat stmt cond) =
    "Repeat\n" ++ statementToString stmt ++ 
    "until " ++ Expr.toString cond ++ ";\n"








