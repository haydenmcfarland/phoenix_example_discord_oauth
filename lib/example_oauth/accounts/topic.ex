defmodule ExampleOauth.Accounts.Topic do
  import Ecto.Changeset
  import Ecto.Query

  use Ecto.Schema
  alias ExampleOauth.Accounts.{User, Topic, Comment}

  schema "topics" do
    field(:title, :string)
    belongs_to(:user, User)
    has_many(:comments, Comment)
  end

  def changeset(%Topic{} = topic, params \\ %{}) do
    topic
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
