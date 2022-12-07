module Main (main) where

import Network.Socket
import Network.Socket.ByteString (recv, sendAll)
import qualified Data.ByteString.Char8 as BSC

main :: IO ()
main = withSocketsDo $ do {
    addr <- head <$> getAddrInfo Nothing (Just "google.com") (Just "http");
    sock <- socket (addrFamily addr) (addrSocketType addr) (addrProtocol addr);
    connect sock (addrAddress addr);
    putStrLn "Successfully connected to google.com!";
    sendAll sock $ BSC.pack "GET / HTTP 1.1\r\n\r\n";
    resp <- recv sock 1024;
    putStrLn $ BSC.unpack resp;
    close sock;
}
