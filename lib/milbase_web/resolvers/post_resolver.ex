defmodule MilbaseWeb.Resolvers.PostResolver do
  alias Milbase.Content
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  
  def posts(_, _, _) do
    {:ok, Content.list_posts()}
  end  

  def create_post(_, %{input: input}, %{context: context}) do
    %{current_user: user} = context
    Content.create_post(Map.put(input, :user_id, user.id))
  end
end
