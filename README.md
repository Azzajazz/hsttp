# hsttp

A basic HTTP server implemented in Haskell.
**WARNING** This is not production safe and probably contains several bugs.

The goals for this project are:
- Implementation using only `Network.Socket`
- Support for HTTP 1.0
- Support for basics of HTTP 1.1
- Any others that are added throughout

## Quickstart
```
stack run
```
Then connect to [http://127.0.0.1:1337] with your browser. This may not work with some browsers since the server is not currently HTTP/1.0, 1.1 or 2 compliant.
