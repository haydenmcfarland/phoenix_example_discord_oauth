defmodule ExampleOauthWeb.CommentsChannel do
  use ExampleOauthWeb, :channel

  alias ExampleOauth.Accounts
  alias ExampleOauth.Accounts.Topic
  alias ExampleOauth.Repo

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)

    # loading nested associations...
    topic =
      Topic
      |> Repo.get(topic_id)
      |> Repo.preload(comments: [:user])

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(_name, %{"content" => content}, socket) do
    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    case Accounts.create_comment(user_id, topic, content) do
      {:ok, comment} ->
        broadcast!(
          socket,
          "comments:#{socket.assigns.topic.id}:new",
          %{comment: comment}
        )

        {:reply, :ok, socket}

      # FIXME: need to add json parsing for changeset
      # via similar to how `mix phoenix.gen.json` prepares views
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end
end
