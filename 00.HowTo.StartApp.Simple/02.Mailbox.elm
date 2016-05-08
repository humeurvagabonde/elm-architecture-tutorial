module Mailbox where

import Html exposing (Html, div, button, text, text)
import Html.Events exposing (onClick)

-- Afficher à l'ecran le chiffre 1 suite à un click de souris

view : Signal.Address Int -> Int -> Html

mb : Signal.Mailbox Int

main : Signal Html