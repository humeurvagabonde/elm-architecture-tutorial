module MouseSignal where

import Mouse
import Html exposing (..)

view : (Int, Int) -> Html
view (x, y) = 
    text (toString x ++ "," ++ toString y)


main : Signal.Signal Html
main =
    -- (a -> result) -> Signal a -> Signal result
    Signal.map view Mouse.position