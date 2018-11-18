import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)


main =
  Browser.element { 
  init = init
  , update = update
  , view = view >> toUnstyled
  , subscriptions = subscriptions }
 

-- MODEL

type alias Model = {isRaptoring: Bool, x: Float, y: Float}

init : () -> ( Model, Cmd Msg )
init _ =
    ( Model False 0 0 
    , Cmd.none
    )



subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- UPDATE

type Msg = StartRaptoring | StopRaptoring | MoveRaptorLeft Float

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    StartRaptoring ->
      ({model | isRaptoring = True}
      , Cmd.none)
    StopRaptoring ->
      ({model | isRaptoring = False}
      , Cmd.none)
    MoveRaptorLeft newPos ->
      ({model | x = newPos}
      , Cmd.none)


theme : { secondary : Color, primary : Color }
theme =
    { primary = hex "55af6a"
    , secondary = rgb 250 240 230
    }

-- VIEW

view : Model -> Html Msg
view model =
  div []
  [   
    p [] [ text (if model.isRaptoring then  "Rarrrrr" else "Sad Raptor") ]
    , button [ onClick StartRaptoring, css [ backgroundColor theme.primary ]] [ text "Start Raptoring" ]
    , button [ onClick StopRaptoring ] [ text "Stop Raptoring" ]
    , button [ onClick (MoveRaptorLeft (model.x + 120 ))] [ text "Move" ]
    , img [src "https://raw.githubusercontent.com/brooksbecton/elm-raptorize/master/assets/raptor.png", css [position absolute, right (px model.x), bottom (px 0)]] []
  ]