defmodule ExampleOauthWeb.TopicController do
  use ExampleOauthWeb, :controller

  alias ExampleOauth.Accounts
  alias ExampleOauth.Accounts.Topic
  alias ExampleOauth.Repo

  plug ExampleOauthWeb.Plugs.RequireAuth
       when action in [
              :new,
              :create,
              :edit,
              :update
            ]

  plug :check_post_owner when action in [:update, :edit, :delete]

  def index(conn, _params) do
    IO.inspect(conn.assigns)
    render(conn, "index.html", topics: Accounts.all_topics())
  end

  def show(conn, %{"id" => topic_id}) do
    render(conn, "show.html", topic: Accounts.get_topic(topic_id))
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    case Accounts.create_topic(conn.assigns.user, topic) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Accounts.get_topic(topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    case Accounts.update_topic(topic_id, topic) do
      {:ok, _result} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset, old_topic} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Accounts.delete_topic(topic_id)

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  def check_post_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn

    if Accounts.get_topic(topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end
