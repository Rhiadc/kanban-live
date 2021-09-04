board = Livekanban.Repo.insert!(%Livekanban.Board{title: "Awesome project"})

backlog = Livekanban.Repo.insert!(%Livekanban.Column{title: "Backlog", board_id: board.id})

_in_progress = Livekanban.Repo.insert!(%Livekanban.Column{title: "In progress", board_id: board.id})
_done = Livekanban.Repo.insert!(%Livekanban.Column{title: "Done", board_id: board.id})

_card = Livekanban.Repo.insert!(%Livekanban.Card{content: "Put some nice cat picture on the homepage", column_id: backlog.id})
