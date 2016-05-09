module CounterPair where

import Html exposing (..)
import Counter
import Signal

-- Model
type alias Model = 
    { topCounter  : Counter.Model
    , bottomCounter : Counter.Model
    }

init : Int -> Int -> Model
init top bottom =
    { topCounter = Counter.init top
    , bottomCounter = Counter.init bottom
    }


-- Update
type Action = Top Counter.Action
    | Bottom Counter.Action

update : Action -> Model -> Model
update action model =
    case action of
        Top a -> 
            { topCounter = Counter.update a model.topCounter
            , bottomCounter = model.bottomCounter
            }
        Bottom a -> {model | bottomCounter = Counter.update a model.bottomCounter}

-- View
view : Signal.Address Action -> Model -> Html
view address model =
    div []
    [ Counter.view (Signal.forwardTo address Top) model.topCounter
    , Counter.view (Signal.forwardTo address Bottom) model.bottomCounter
    ]
