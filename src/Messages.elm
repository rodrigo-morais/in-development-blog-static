module Messages exposing (..)


import Http


import Models exposing (..)


type Msg
  = NoOp
  | GetPosts
  | FetchPostsSucceed (Posts)
  | FetchPostSucceed PostStatic
  | FetchPostsFail Http.Error
  | ShowPosts
  | ShowAdmin
  | ShowPost Int