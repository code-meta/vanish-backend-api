defmodule VanishApi.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field(:msg_id, :string)
    field(:creator_id, :string)
    field(:from_room_id, :string)
    field(:creator_name, :string)
    field(:created_at, :utc_datetime)
    field(:expiry, :utc_datetime)
    field(:message_payload, :map)
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [
      :msg_id,
      :creator_id,
      :from_room_id,
      :creator_name,
      :created_at,
      :expiry,
      :message_payload
    ])
    |> validate_required([
      :msg_id,
      :creator_id,
      :from_room_id,
      :creator_name,
      :created_at,
      :expiry,
      :message_payload
    ])
  end
end
