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

  def new_record(%{chat: chat}) do
    %{data: any_data(chat)}
  end

  defp data(%Chat{} = chat) do
    %{
      id: chat.id,
      name: chat.creator_name,
    }
  end

  defp any_data(%Chat{} = chat) do
    chat
    |> Map.from_struct()
    |> Map.drop([:__meta__, :inserted_at, :updated_at])
  end

end
