defmodule Livekanban.Repo.Migrations.CreateColumns do
  use Ecto.Migration

  def change do
    create table(:columns, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :board_id, references(:boards, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:columns, [:board_id])
  end
end
