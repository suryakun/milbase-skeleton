defmodule MilbaseWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias MilbaseWeb.Schema.Types

  import_types Types.UserType
  import_types Types.SessionType
  import_types Types.PostType
  import_types Types.CommentType

  #Import queries
  import_types MilbaseWeb.Schema.Query.UserQuery
  import_types MilbaseWeb.Schema.Query.PostQuery
  import_types MilbaseWeb.Schema.Query.CommentQuery

  #import mutations
  import_types MilbaseWeb.Schema.Mutation.UserMutation
  import_types MilbaseWeb.Schema.Mutation.SessionMutation
  import_types MilbaseWeb.Schema.Mutation.PostMutation
  import_types MilbaseWeb.Schema.Mutation.CommentMutation

  #import subscriptions
  import_types MilbaseWeb.Schema.Subscription.CommentSubscription
end
