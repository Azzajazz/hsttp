module Main (main) where

import Network.Socket
import Network.Socket.ByteString (recv, sendAll)
import qualified Data.ByteString.Char8 as BSC

page :: BSC.ByteString
page = BSC.pack "HTTP/1.1 200 OK\r\n\r\n\
\<head>\r\n\
\</head>\r\n\
\<body>\r\n\
\  <h1>Hello, World!</h1>\r\n\
\</body>\r\n\r\n"

main :: IO ()
main = withSocketsDo $ do
    let hints = defaultHints {
        addrFamily     = AF_INET,
        addrSocketType = Stream,
        addrProtocol   = 6,
        addrAddress    = SockAddrInet 1337 $ tupleToHostAddress (127, 0, 0, 1)
    }
    addr <- head <$> getAddrInfo (Just hints) (Just "localhost") Nothing
    sock <- openSocket addr
    putStrLn "Created socket."
    bind sock $ SockAddrInet 1337 $ tupleToHostAddress (127, 0, 0, 1)
    putStrLn $ "Socket bound to address 127.0.0.1:1337"
    listen sock 1
    putStrLn "Socket listening for connections..."
    (csock, caddr) <- accept sock
    putStrLn $ "Accepted connection from " ++ (show caddr)
    req <- recv csock 1024
    putStrLn $ BSC.unpack req
    sendAll csock page
    close csock
    close sock 

