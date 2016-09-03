module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.App as App


type Cmd
    = Increment


type alias Model =
    Int


initModel : Model
initModel =
    0


update : Cmd -> Model -> Model
update command model =
    model + 1


view : Model -> Html Cmd
view model =
    div []
        [ div []
            [ text "Current counter: "
            , text (toString model)
            ]
        , button [ onClick Increment ] [ text "+" ]
        ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
