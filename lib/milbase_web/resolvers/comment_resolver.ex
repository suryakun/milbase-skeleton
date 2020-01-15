defmodule MilbaseWeb.Resolvers.CommentResolver do
  alias Milbase.Content

  def comments(_, _, _) do
    {:ok, Content.list_comments()}
  end

  def create_comment(_, %{input: input}, %{context: context}) do
    %{current_user: user} = context
    inputComment = Map.put(input, :user_id, user.id)
    Content.create_comment(inputComment)
  end
end
