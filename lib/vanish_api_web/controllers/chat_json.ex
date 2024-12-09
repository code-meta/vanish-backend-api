defmodule VanishApiWeb.ChatJSON do
  alias VanishApi.Chats.Chat

  @doc """
  Renders a list of chats.
  """
  def index(%{chats: chats}) do
    %{data: for(chat <- chats, do: data(chat))}
  end

  @doc """
  Renders a single chat.
  """
  # def show(%{chat: chat}) do
  #   %{data: data(chat)}
  # end

  def show(%{chat: chat}) do
    %{data: chat}
  end

  defp data(%Chat{} = chat) do
    %{
      id: chat.id,
      name: chat.name,
      age: chat.age
    }
  end
end
