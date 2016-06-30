module Update exposing (..)


import Base64


import Routing.Models exposing (..)
import Routing.Config exposing (routerConfig)
import Routing.Utils exposing (reverse, navigationCmd)


import Messages exposing (..)
import Commands exposing (..)
import Models exposing (AppModel)


update : Msg -> AppModel -> (AppModel, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)

    GetPosts ->
      (model, getPosts)

    FetchPostsSucceed posts ->
      ( { model | posts = posts }
      , Cmd.none
      )

    FetchPostSucceed post ->
      let
        p = 
          (Debug.log ("FetchPostSucceed -> " ++ post.sha))
          Base64.decode post.content

        pStr =
          case p of
            Ok post -> (toString post)
            Err _ -> ""
      in
        case p of
            Ok post -> ( { model | post = post }, Cmd.none )
            Err _ -> ( model, Cmd.none )

    FetchPostsFail _ ->
      (Debug.log "FetchPostsFail")
      (model, Cmd.none)

    ShowPosts ->
      let
        path =
          reverse PostsRoute
      in
        ( model, navigationCmd path )

    ShowAdmin ->
      let
        path =
          reverse AdminRoute
      in
        ( model, navigationCmd path )

    ShowPost postId ->
      let
        path =
          reverse (PostRoute postId)

      in
        ( model, Cmd.batch [getPost postId, navigationCmd path] )