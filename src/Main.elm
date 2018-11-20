module Main exposing (Model, Msg(..), init, main, subscriptions, theme, update, view)

import Browser
import Browser.Events exposing (onAnimationFrame)
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)
import Task
import Time


main =
    Browser.element
        { init = init
        , update = update
        , view = view >> toUnstyled
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { isRaptoring : Bool
    , time : Time.Posix
    , x : Float
    , y : Float
    , zone : Time.Zone
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model False (Time.millisToPosix 0) 0 0 Time.utc
    , Cmd.none
    )



-- UPDATE


type Msg
    = StartRaptoring
    | StopRaptoring
    | Tick Time.Posix
    | MoveRaptorLeft Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MoveRaptorLeft newTime ->
            ( if model.isRaptoring then { model | x = model.x + 10 } else model
            , Cmd.none
            )

        StartRaptoring ->
            ( { model | isRaptoring = True }
            , Cmd.none
            )

        StopRaptoring ->
            ( { model | isRaptoring = False }
            , Cmd.none
            )

        Tick newTime ->
            ( { model | time = newTime }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    onAnimationFrame MoveRaptorLeft
    


theme : { secondary : Color, primary : Color }
theme =
    { primary = hex "55af6a"
    , secondary = rgb 250 240 230
    }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [  p []
            [ text
                (if model.isRaptoring then
                    "Rarrrrr"

                 else
                    "Sad Raptor"
                )
            ]
        , button [ onClick StartRaptoring, css [ backgroundColor theme.primary ] ] [ text "Start Raptoring" ]
        , button [ onClick StopRaptoring ] [ text "Stop Raptoring" ]
        , img [ src "https://raw.githubusercontent.com/brooksbecton/elm-raptorize/master/assets/raptor.png", css [ position absolute, right (px model.x), bottom (px 0) ] ] []
        ]
