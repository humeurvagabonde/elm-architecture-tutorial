module UpdateArchi (..) where

import Html exposing (..)
import Mouse

type alias Model = 
    {counter : Int}

initModel : Model
initModel = {
    counter = 0
    }

view : Model -> Html
view model =
  text (toString model.counter)

-- (a -> state -> state) -> state -> Signal a -> Signal state
modelSignal : Signal.Signal Model
modelSignal =
    Signal.foldp (\_ state -> {state | counter = state.counter + 1}) initModel Mouse.clicks

main : Signal.Signal Html
main =
    Signal.map view modelSignal