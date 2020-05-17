defmodule ExampleOauth.Accounts.User do
  import Ecto.Changeset
  import Ecto.Query

  use Ecto.Schema
  alias ExampleOauth.Accounts.{User, Topic, Comment}

  @derive {Jason.Encoder, only: [:email]}
  schema "users" do
    field(:email, :string)
    field(:provider, :string)
    field(:token, :string)
    has_many(:topics, Topic)
    has_many(:comments, Comment)

    timestamps()
  end

  def changeset(%User{} = user, params \\ {}) do
    user
    |> cast(params, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
    |> unique_constraint(:email)
  end
end
