defmodule VanishApi.ChatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VanishApi.Chats` context.
  """

  @doc """
  Generate a chat.
  """
  def chat_fixture(attrs \\ %{}) do
    {:ok, chat} =
      attrs
      |> Enum.into(%{
        age: 42,
        name: "some name"
      })
      |> VanishApi.Chats.create_chat()

    chat
  end
end
