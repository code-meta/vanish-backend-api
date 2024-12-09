defmodule VanishApi.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field :name, :string
    field :age, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
