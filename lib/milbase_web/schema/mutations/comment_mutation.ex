defmodule MilbaseWeb.Schema.Mutation.CommentMutation do
  use Absinthe.Schema.Notation
  alias MilbaseWeb.Resolvers

  object :comment_mutations do
    @desc "create new comment"
    field :create_comment, type: :comment_type do
      arg(:input, non_null(:comment_input_type))
      resolve &Resolvers.CommentResolver.create_comment/3
    end
  end
end
