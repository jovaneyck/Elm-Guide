module Main exposing (..)

import Task
import Http
import Json.Decode as Json
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App exposing (..)


type alias Model =
    { topic : String
    , gifUrl : String
    }


type Msg
    = Next
    | FetchSuccess String
    | FetchFailed Http.Error


init : ( Model, Cmd Msg )
init =
    ( { topic = "cats", gifUrl = "waiting.gif" }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Next ->
            ( model, getRandomGif model.topic )

        FetchSuccess url ->
            ( { model | gifUrl = url }, Cmd.none )

        FetchFailed _ ->
            ( model, Cmd.none )


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag="
                ++ topic
    in
        Task.perform FetchFailed FetchSuccess (Http.get decodeUrl url)


decodeUrl : Json.Decoder String
decodeUrl =
    Json.at [ "data", "image_url" ] Json.string


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ h2 [] [ text model.topic ]
            , img [ src model.gifUrl ] []
            ]
        , button [ onClick Next ] [ text "Next image!" ]
        ]


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
