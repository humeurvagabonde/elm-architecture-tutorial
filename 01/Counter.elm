module Counter where

import Html exposing (..)
import Html.Attributes exposing (id)
import Html.Events exposing (onClick)

-- Model
type alias Model = Int

-- Update
type Action = Increment | Decrement

update : Action -> Model -> Model
update action model = 
    case action of
        Increment -> model + 1
        Decrement -> model - 1

-- View
view : Signal.Address Action -> Model -> Html
view address model = 
    div [id "mainId"] 
    [
        h1 [] [text "Mon premier compteur"],
        button [onClick address Decrement] [text "-"],
        span [] [text (toString model)],
        button [onClick address Increment] [text "+"]
    ]