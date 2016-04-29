module Counter where

import Html exposing (..)
import Html.Attributes exposing (id)
-- Model
type alias Model = Int

-- Update
type Action = Increment | Decrement

update : Action -> Model -> Model
update action model = 42

-- View
view : Signal.Address Action -> Model -> Html
view address action = 
    div [id "mainId"] 
    [
        h1 [] [text "Mon premier compteur"]
    ]