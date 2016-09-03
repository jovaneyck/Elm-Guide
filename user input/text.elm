module Main exposing (main)

import String exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Html.App as App


type alias Model =
    { content : String }


type Cmd
    = Changed String


initModel : Model
initModel =
    { content = "" }


update : Cmd -> Model -> Model
update cmd model =
    case cmd of
        Changed newContent ->
            { model | content = newContent }


view : Model -> Html Cmd
view model =
    div []
        [ input
            [ placeholder "Type something here..."
            , onInput Changed
            ]
            []
        , p [] [ text ("In reverse: " ++ (model.content |> String.reverse)) ]
        ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
