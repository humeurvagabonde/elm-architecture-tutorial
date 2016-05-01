module Mailbox where

import Html exposing (Html, div, button, text, text)
import Html.Events exposing (onClick)

view : Signal.Address Int -> Int -> Html

mb : Signal.Mailbox Int

main : Signal Html