module HowToStartApp where 

import Html exposing (..)
import Html.Events exposing (..)
import Signal
import Effects exposing (Effects)
import Http
import Task

type alias Model = String

type Action = NoOp
    | Refresh
    | OnRefresh (Result Http.Error String)


view : Signal.Address Action -> Model -> Html
view address model = 
    div []
    [
        p [] [text model]
    ,   button [onClick address Refresh] [text "Refresh"]
    ]

actionsMailbox : Signal.Mailbox (List Action)
actionsMailbox =
    Signal.mailbox []

oneActionAddress : Signal.Address Action
oneActionAddress =
    Signal.forwardTo actionsMailbox.address (\action -> [action])

update : Action -> Model -> (Model, Effects Action)
update action model =
    case action of
        Refresh ->
            (model, refreshFx)
        OnRefresh result ->
            let 
                modelUpdated =
                    Result.withDefault "" result
            in
                (modelUpdated, Effects.none)
        _ -> 
            (model, Effects.none)

httpTask : Task.Task Http.Error String
httpTask =
    Http.getString "http://localhost:3000"

refreshFx : Effects Action
refreshFx =
    httpTask
    |> Task.toResult --Task Error String -> Task never (Result Error String)
    |> Task.map OnRefresh -- (Result Error String -> Action) -> Task never (Result Error String) -> Task never Action
    |> Effects.task -- Task Never Action -> Effects Action


modelAndFxSignal : Signal.Signal (Model, Effects Action)
modelAndFxSignal =
    let
        -- modelAndFx : Action -> (Model, Effects) -> (Model, Effects)
        modelAndFx action (previousModel, _) =
            update action previousModel

        -- modelAndManyFx : List Action -> (Model, Effects) -> (Model, Effects)
        modelAndManyFx actions (previousModel, effects) =
            List.foldl modelAndFx (previousModel, Effects.none) actions
        initial =
            ("-", Effects.none)
    in
        Signal.foldp modelAndManyFx initial actionsMailbox.signal

fxSignal : Signal.Signal (Effects Action)
fxSignal =
    Signal.map snd modelAndFxSignal

modelSignal : Signal.Signal Model
modelSignal =
    Signal.map fst modelAndFxSignal

main : Signal.Signal Html
main = 
    Signal.map (view oneActionAddress) modelSignal

port runners : Signal.Signal (Task.Task Effects.Never ())
port runners =
    -- toTask : Address (List a) -> Effects a -> Task Never ()
    Signal.map (Effects.toTask actionsMailbox.address) fxSignal