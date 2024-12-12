defmodule VanishApi.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add(:msg_id, :string, null: false)
      add(:creator_id, :string, null: false)
      add(:from_room_id, :string, null: false)
      add(:creator_name, :string, null: false)
      add(:created_at, :utc_datetime, null: false)
      add(:expiry, :utc_datetime, null: false)
      add(:message_payload, :map, null: false)

      timestamps(type: :utc_datetime)
    end
  end
end
