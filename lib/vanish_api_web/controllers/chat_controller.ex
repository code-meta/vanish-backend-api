defmodule VanishApiWeb.ChatController do
  use VanishApiWeb, :controller

  alias VanishApi.Chats
  alias VanishApi.Chats.Chat

  action_fallback(VanishApiWeb.FallbackController)

  def index(conn, _params) do
    chats = Chats.list_chats()
    render(conn, :index, chats: chats)
  end

  def create_message(conn, chat_params) do
    required_keys = [
      "msg_id",
      "creator_id",
      "from_room_id",
      "creator_name",
      "expiry",
      "message_payload"
    ]

    missing_keys = Enum.filter(required_keys, fn key -> not Map.has_key?(chat_params, key) end)

    if missing_keys != [] do
      conn
      |> put_status(:bad_request)
      |> json(%{error: "Missing keys", missing_keys: missing_keys})
    else
      # Destructure if everything is present
      %{
        "msg_id" => msg_id,
        "creator_id" => creator_id,
        "from_room_id" => from_room_id,
        "creator_name" => creator_name,
        "expiry" => expiry,
        "message_payload" => message_payload
      } = chat_params

      attrs = %{
        msg_id: msg_id,
        creator_id: creator_id,
        from_room_id: from_room_id,
        creator_name: creator_name,
        created_at: DateTime.utc_now(),
        expiry: DateTime.utc_now() |> DateTime.add(expiry * 60, :second),
        message_payload: message_payload
      }

      IO.puts("********************")
      IO.inspect(attrs)
      IO.puts("********************")

      case Chats.create_chat(attrs) do
        {:ok, chat} ->
          conn
          |> put_status(:created)
          |> render(:new_record, chat: chat)

        {:error, changeset} ->
          errors = format_errors(changeset.errors)

          conn
          |> put_status(:unprocessable_entity)
          |> json(%{errors: errors})
      end
    end
  end

  defp format_errors(errors) do
    Enum.map(errors, fn {field, {message, _}} ->
      %{field: field, message: message}
    end)
  end
end
