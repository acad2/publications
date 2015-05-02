import Data.Heap

data Item a = Tree { probability :: Double, left ::  (Item a), right :: (Item a)} | Symbol {probability :: Double, symbol :: a}

huffman :: [(Double,a)] -> Item Int
huffman _ = huffman 
