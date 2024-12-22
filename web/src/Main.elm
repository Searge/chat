module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onSubmit)



-- MAIN


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { draft : String
    , messages : List String
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { draft = ""
      , messages = []
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = DraftChanged String
    | MessageSubmitted


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DraftChanged newDraft ->
            ( { model | draft = newDraft }
            , Cmd.none
            )

        MessageSubmitted ->
            ( { model
                | messages = model.draft :: model.messages
                , draft = ""
              }
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.form [ onSubmit MessageSubmitted ]
            [ input
                [ type_ "text"
                , placeholder "Type a message"
                , value model.draft
                , onInput DraftChanged
                ]
                []
            , button [ type_ "submit" ] [ text "Send" ]
            ]
        , div []
            (List.map (\msg -> p [] [ text msg ]) (List.reverse model.messages))
        ]
