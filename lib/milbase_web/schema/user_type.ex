defmodule MilbaseWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation
  #alias Milbase.Content.Post

  object :user_type do
    field :id, :id
    field :name, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :role, :string

    # Uncomment this if you want to populate the posts without pagination
    #field :posts, list_of(:post_type), resolve: assoc(:posts)
    #
    #
    #
    # Uncomment this below code if you want to populate the posts with pagination
    #connection field :posts, node_type: :post_con do
    #  resolve fn
    #    pagination_args, _source -> 
    #      Post
    #      |> Absinthe.Relay.Connection.from_query(&Milbase.Repo.all/1, pagination_args)
    #  end
    #end
  end

  input_object :user_input_type do
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :password_confirmation, non_null(:string)
  end

end
