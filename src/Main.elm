import Browser
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css, href, src)
import Html.Styled.Events exposing (onClick)


main =
  Browser.sandbox { init = init, update = update, view = view >> toUnstyled }
 

-- MODEL

type alias Model = {isRaptoring: Bool, x: Float, y: Float}

init : Model
init =
  {isRaptoring = False, x = 0, y = 0}


-- UPDATE

type Msg = StartRaptoring | StopRaptoring | MoveRaptorLeft Float

update : Msg -> Model -> Model
update msg model =
  case msg of
    StartRaptoring ->
      {model | isRaptoring = True}
    StopRaptoring ->
      {model | isRaptoring = False}
    MoveRaptorLeft newPos ->
      {model | x = newPos}

-- VIEW

theme : { secondary : Color, primary : Color }
theme =
    { primary = hex "55af6a"
    , secondary = rgb 250 240 230
    }


view : Model -> Html Msg
view model =
  div []
  [   
    p [] [ text (if model.isRaptoring then  "Rarrrrr" else "Sad Raptor") ]
    , button [ onClick StartRaptoring, css [ backgroundColor theme.primary ]] [ text "Start Raptoring" ]
    , button [ onClick StopRaptoring ] [ text "Stop Raptoring" ]
    , button [ onClick (MoveRaptorLeft (model.x + 120 ))] [ text "Move" ]
    , img [src "assets/raptor.png", css [position absolute, right (px model.x), bottom (px 0)]] []
  ]