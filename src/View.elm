module View exposing (..)


import Html exposing (div, text, h1, a)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, class, href, id)
import Markdown


import Models exposing (..)
import Messages exposing (..)


import Routing.Models exposing (..)


view : AppModel -> Html.Html Msg
view model =
  div []
      [ menu
      , pageView model
      ]
    


menu : Html.Html Msg
menu =
    div [ style [("background-color", "#000000"), ("color", "#FFFFFF")] ]
        [ div []
              [ menuLink ShowPosts "btnPosts" "Posts"
              , text " | "
              , menuLink ShowAdmin "btnAdmin" "Admin"
              ]
        ]


menuLink : Msg -> String -> String -> Html.Html Msg
menuLink message viewId label =
    a [ id viewId
      , href "javascript://"
      , onClick message
      , style [("text-decoration", "none"), ("color", "#FFFFFF")]
      ]
      [ text label ]


pageView : AppModel -> Html.Html Msg
pageView model =
  let
    postsVW =
      case model.posts of
        [] -> 
          div []
              [ text "Loading...." ]
        _ ->
          postsView model.posts
      
  in
    case model.route of
      PostsRoute ->
        div []
            [ h1  [ style [("margin-left", "1em")] ]
                  [ text model.title ]
            , div [ style [("margin-top", "1em")] ]
                  [ postsVW ]
            ]

      AdminRoute ->
        div []
            [ h1 [ id "title"]
                 [ text "Admin" ]
            ]

      PostRoute postId ->
        let
          pText =
            (Debug.log model.post)
            model.post
        in
          div [style [("margin-top", "1em")]]
              [ postViewStatic pText ]

      NotFoundRoute ->
        notFoundView


notFoundView : Html.Html msg
notFoundView =
    div [ style [("margin-top", "1em")] ]
        [ text "Not Found" ]


postsView : Posts -> Html.Html Msg
postsView posts =
  let
    postList = List.map postView posts

  in
    div []
        postList


postView : Post -> Html.Html Msg
postView post =
  let
    postId = "posts-" ++ (toString post.id)

  in
    a [ id postId
      , href "javascript://"
      , onClick (ShowPost post.id)
      , style [("text-decoration", "none"), ("color", "#000000")]
      ]
      [
        div [ style [("border", "solid 1px #000000"), ("width", "70%"), ("left", "10%"), ("position", "relative"), ("float", "left"), ("margin-bottom", "0.5em")] ]
            [ div [ style [("margin", "0.5em 0 0 0.5em")]]
                  [
                    postText post.text
                  ]
            , div [style [("text-align", "right"), ("margin", "0.5em 0.5em 0.5em 0"), ("font-size", "0.8em")]]
                  [ text post.author ]
            ]
      ]


postViewStatic : String -> Html.Html Msg
postViewStatic post =
  a [ id "post-static"
    , href "javascript://"
    , style [("text-decoration", "none"), ("color", "#000000")]
    ]
    [
      div [ style [("border", "solid 1px #000000"), ("width", "70%"), ("left", "10%"), ("position", "relative"), ("float", "left"), ("margin-bottom", "0.5em")] ]
          [ div [ style [("margin", "0.5em 0 0 0.5em")]]
                [
                  postText post
                ]
          ]
    ]


postText : String -> Html.Html Msg
postText text =
  Markdown.toHtml [class "content hlsj"] text