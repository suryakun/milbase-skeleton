defmodule MilbaseWeb.Resolvers.CommentResolver do
  alias Milbase.Content

  def comments(_, _, _) do
    {:ok, Content.list_comments()}
  end

  def create_comment(_, %{input: input}, %{context: context}) do
    %{current_user: user} = context
    inputComment = Map.put(input, :user_id, user.id)
    comment = Content.create_comment(inputComment)
    #Absinthe.Subscription.publish(MilbaseWeb.Endpoint, subcomment, comment_added: "comment_added" )
    comment
  end
end
