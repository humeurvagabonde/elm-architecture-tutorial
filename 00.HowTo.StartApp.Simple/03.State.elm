module State (..) where

import Html exposing (..)
import Mouse


view : Int -> Html
view counter =
  text (toString counter)

-- (a -> state -> state) -> state -> Signal a -> Signal state
countState : Signal.Signal Int
countState =
    Signal.foldp (\_ state -> state + 1) 0 Mouse.clicks

main : Signal.Signal Html
main =
    Signal.map view countState

