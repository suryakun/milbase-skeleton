defmodule MilbaseWeb.Schema.Subscription.CommentSubscription do
  use Absinthe.Schema.Notation

  object :comment_subscriptions do
    field :comment_added, type: :comment_type do
      arg(:input, non_null(:comment_input_type))

      config fn args, _ ->
        {:ok, topic: args.input.text}
      end

      trigger :create_commet, topic: fn comment ->
        comment.text
      end

      resolve fn comment, _, _ ->
        {:ok, comment}
      end
    end
  end
end
