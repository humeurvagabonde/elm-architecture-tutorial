module Mailbox where

import Html exposing (Html, div, button, text, text)
import Html.Events exposing (onClick)

view : Signal.Address Int -> Int -> Html
view address message = 
    div [] 
    [ text (toString message)
    , button [onClick address 1] [text "Click me"]
    ]

mb : Signal.Mailbox Int
mb =
    Signal.mailbox 0

main : Signal Html
main = 
    Signal.map (view mb.address) mb.signal