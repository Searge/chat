module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- MAIN

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


-- MODEL

type alias Message =
    { id : Int
    , text : String
    }

type alias Model =
    { messages : List Message
    , draft : String
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( { messages = []
      , draft = ""
      }
    , Cmd.none
    )


-- UPDATE

type Msg
    = DraftChanged String
    | SendMessage

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DraftChanged newDraft ->
            ( { model | draft = newDraft }
            , Cmd.none
            )

        SendMessage ->
            if String.isEmpty (String.trim model.draft) then
                ( model, Cmd.none )
            else
                ( { model
                    | messages = model.messages ++ [ Message (List.length model.messages) model.draft ]
                    , draft = ""
                  }
                , Cmd.none
                )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


-- VIEW

view : Model -> Html Msg
view model =
    div [ class "chat-container" ]
        [ div [ class "messages" ]
            (List.map viewMessage model.messages)
        , div [ class "input-area" ]
            [ input
                [ type_ "text"
                , value model.draft
                , onInput DraftChanged
                , placeholder "Type a message..."
                ]
                []
            , button [ onClick SendMessage ] [ text "Send" ]
            ]
        ]

viewMessage : Message -> Html Msg
viewMessage message =
    div [ class "message" ]
        [ text message.text ]