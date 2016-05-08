module RandomGif where

import Html exposing (..)
import Html.Events exposing (..)
import Signal
import Task
import Effects
import Http
import Json.Decode as Json

-- MODEL

type alias Model =
    { topic : String
    , gifUrl : String
    }

init : String -> (Model, Effects Action)
init topic =
    ( Model topic "assets/waiting.gif"
    , 

-- UPDATE

type alias Action
    = RequestMore
    | NewGif (Maybe String)

update : Action -> Model -> (Model, Effects.Effects Action)
update action model =
    case action of
        RequestMore ->
            (model, getRandomGif model.topic)
        NewGif maybeUrl ->
            ( Model model.topic (Maybe.withDefault model.gifUrl maybeUrl)
            , Effects.Effects.none)

getRandomGif : String -> Effects.EFfects Action
getRandomGif topic =
    Http.get decodeUrl (randomUrl topic)
    |> Task.toMaybe
    |> Task.map NewGif
    |> Effects.task

-- Http.url : String -> List (String, String) -> String
-- Http.get : Decoder value -> String -> Task Error value

randomUrl : String -> String
randomUrl topic =
  Http.url "http://api.giphy.com/v1/gifs/random"
    [ "api_key" => "dc6zaTOxFJmzC"
    , "tag" => topic
    ]

decodeUrl : Json.Decoder String
decodeUrl =
  Json.at ["data", "image_url"] Json.string