defmodule LivekanbanWeb.PageLive do
  use LivekanbanWeb, :live_view
  alias Livekanban.Board
  alias LivekanbanWeb.Endpoint

  @impl true
  def mount(_params, %{"board_id" => board_id}, socket) do
    with {:ok, board} <- Board.find_by!(board_id) do
      Endpoint.subscribe(topic(board_id))
      {:ok, assign(socket, :board, board)}
    else
      {:error, _reason} ->{:ok, redirect(socket, to: "error")}
    end
  end

  @impl true
  def handle_event("add_card", %{"column" => column_id}, socket) do
    %Livekanban.Card{column_id: column_id, content: "Something new"} |> Livekanban.Repo.insert!()
    generate_and_broadcast(socket)

  end

  def handle_event("update_card", %{"card" => card_id, "value" => new_content}, socket) do
    Livekanban.Card.update(card_id, %{content: new_content})
    generate_and_broadcast(socket)

  end

  defp generate_and_broadcast(socket) do
    {:ok, new_board} = Livekanban.Board.find_by!(socket.assigns.board.id)
    Endpoint.broadcast(topic(new_board.id), "board:updated", new_board)
    {:noreply, assign(socket, :board, new_board)}
  end

  def handle_info(%{topic: message_topic, event: "board:updated", payload: board}, socket) do
    cond do
      topic(board.id) == message_topic ->
        {:noreply, assign(socket, :board, Livekanban.Repo.preload(board, column: :card))}
      true ->
        {:noreply, socket}
    end
  end

  def topic(board_id) do
    "board:#{board_id}"
  end
end
