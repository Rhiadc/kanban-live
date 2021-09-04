defmodule LivekanbanWeb.PageLive do
  use LivekanbanWeb, :live_view
  alias Livekanban.Board

  @impl true
  def mount(_params, %{"board_id" => board_id}, socket) do
    with {:ok, board} <- Board.find_by!(board_id) do
      {:ok, assign(socket, :board, board)}
    else
      {:error, _reason} ->{:ok, redirect(socket, to: "error")}
    end
  end

  @impl true
  def handle_event("add_card", %{"column" => column_id}, socket) do
    %Livekanban.Card{column_id: column_id, content: "Something new"} |> Livekanban.Repo.insert!()
    {:ok, new_board} = Livekanban.Board.find_by!(socket.assigns.board.id)
    {:noreply, assign(socket, :board, new_board)}
  end

end
