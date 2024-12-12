defmodule VanishApiWeb.RoomChannel do
  use Phoenix.Channel

  # This function will be called when a user joins a channel (like room:roomid4242424)
  def join("room:" <> room_id, _message, socket) do
    IO.puts("User joined room #{room_id}")
    {:ok, assign(socket, :room_id, room_id)}
  end

  # Handle incoming messages
  def handle_in("new_msg", %{"body" => body}, socket) do
    room_id = socket.assigns[:room_id]

    broadcast!(socket, "new_msg", %{body: body, room: room_id})

    {:noreply, socket}
  end

  # You can also handle other types of events dynamically
  def handle_in("user_typing", %{"user" => user}, socket) do
    room_id = socket.assigns[:room_id]
    broadcast!(socket, "user_typing", %{user: user, room: room_id})
    {:noreply, socket}
  end

  # Handle other events as needed, for example:
  def handle_in("file_upload", %{"file" => file}, socket) do
    room_id = socket.assigns[:room_id]
    # Logic for handling file uploads can go here
    broadcast!(socket, "file_uploaded", %{file_name: file["name"], room: room_id})
    {:noreply, socket}
  end

  # Handle when a user leaves the room
  def handle_out("new_msg", payload, socket) do
    push(socket, "new_msg", payload)
    {:noreply, socket}
  end

  def handle_out("user_typing", payload, socket) do
    push(socket, "user_typing", payload)
    {:noreply, socket}
  end
end
