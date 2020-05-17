defmodule ExampleOauth.Accounts do
  import Ecto.Query

  alias ExampleOauth.Repo
  alias ExampleOauth.Accounts.{User, Topic, Comment}

  def get_user(user_id) do
    Repo.get(User, user_id)
  end

  def insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)

      user ->
        {:ok, user}
    end
  end

  def all_topics do
    Repo.all(Topic)
  end

  def get_topic(topic_id) do
    Repo.get!(Topic, topic_id)
  end

  def create_topic(user, topic) do
    changeset =
      user
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic)

    Repo.insert(changeset)
  end

  def update_topic(topic_id, new_topic) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, new_topic)

    case Repo.update(changeset) do
      {:ok, topic} -> {:ok, topic}
      {:error, changeset} -> {:error, changeset, old_topic}
    end
  end

  def delete_topic(topic_id) do
    Repo.get!(Topic, topic_id) |> Repo.delete!()
  end

  def create_comment(user_id, topic, content) do
    changeset =
      topic
      |> Ecto.build_assoc(:comments, user_id: user_id)
      |> Repo.preload(:user)
      |> Comment.changeset(%{content: content})

    Repo.insert(changeset)
  end
end
