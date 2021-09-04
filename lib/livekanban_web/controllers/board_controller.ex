defmodule LivekanbanWeb.BoardController do
  use LivekanbanWeb, :controller
  import Phoenix.LiveView.Controller

  def show(conn, %{"id" => id}) do
    live_render(conn, LivekanbanWeb.PageLive, session: %{"board_id" => id})
  end
end
