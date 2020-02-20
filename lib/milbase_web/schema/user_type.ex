defmodule MilbaseWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation

  #alias Milbase.Content.Post

  object :user_type, description: "Entity of someone" do
    field :id, :id, description: "ID"
    field :name, :string, description: "Name"
    field :first_name, :string, description: "Required first name"
    field :last_name, :string, description: "optional last name"
    field :email, :string, description: "Required email"
    field :role, :string, description: "Role"
    field :inserted_at, :string, description: "Inserted at"

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
    field :last_name, :string
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :password_confirmation, non_null(:string)
  end

end
