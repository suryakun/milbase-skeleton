defmodule MilbaseWeb.Schema.Mutation.PostMutation do
  use Absinthe.Schema.Notation
  alias MilbaseWeb.Resolvers

  object :post_mutations do
    @desc "create new post"
    field :create_post, type: :post_type do
      arg(:input, non_null(:post_input_type))
      resolve &Resolvers.PostResolver.create_post/3
    end
  end
end

