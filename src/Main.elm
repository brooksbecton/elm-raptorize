import Browser
import Html exposing (Html, img, button, div, p,  text)
import Html.Attributes exposing (src, style)
import Html.Events exposing (onClick)
import Css exposing (..)


main =
  Browser.sandbox { init = init, update = update, view = view }
 

-- MODEL

type alias Model = {isRaptoring: Bool}

init : Model
init =
  {isRaptoring = False}


-- UPDATE

type Msg = StartRaptoring | StopRaptoring

update : Msg -> Model -> Model
update msg model =
  case msg of
    StartRaptoring ->
      {model | isRaptoring = True}
    StopRaptoring ->
      {model | isRaptoring = False}

-- VIEW

view : Model -> Html Msg
view model =
  div []
  [   
    p [] [ text (if model.isRaptoring then  "Rarrrrr" else "Sad Raptor") ]
    , button [ onClick StartRaptoring] [ text "Start Raptoring" ]
    , button [ onClick StopRaptoring ] [ text "Stop Raptoring" ]
    , img [src "assets/raptor.png"] []
  ]