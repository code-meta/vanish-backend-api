defmodule VanishApi.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :name, :string
      add :age, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
