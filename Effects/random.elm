module Main exposing (..)

import Random exposing (generate)
import Html exposing (..)
import Html.Events exposing (..)
import Html.App as App


type alias Model =
    { face : Int }


type Msg
    = Roll
    | NewFace Int


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (model.face |> toString) ]
        , button [ onClick Roll ] [ text "Roll" ]
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace f ->
            ( { model | face = f }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( { face = 1 }, Cmd.none )


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
