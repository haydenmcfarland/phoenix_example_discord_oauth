defmodule ExampleOauth.Accounts.Comment do
  import Ecto.Changeset

  use Ecto.Schema
  alias ExampleOauth.Accounts.{User, Topic, Comment}

  @derive {Jason.Encoder, only: [:content, :user]}
  schema "comments" do
    field(:content, :string)
    belongs_to(:user, User)
    belongs_to(:topic, Topic)

    timestamps()
  end

  def changeset(%Comment{} = comment, params \\ {}) do
    comment
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
