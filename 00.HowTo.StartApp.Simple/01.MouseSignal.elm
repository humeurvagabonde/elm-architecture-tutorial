module MouseSignal where

import Mouse
import Html exposing (..)

-- Afficher les coordonnées de la souris.

view : (Int, Int) -> Html

-- Signal.map : (a -> result) -> Signal a -> Signal result
main : Signal.Signal Html
