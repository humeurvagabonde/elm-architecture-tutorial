import CounterPair exposing (update, view)
import StartApp.Simple exposing (start)

main =
  start
    { model = 0 0
    , update = update
    , view = view
    }
