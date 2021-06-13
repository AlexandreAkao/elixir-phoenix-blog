defmodule PfuWeb.TipoController do
  use PfuWeb, :controller
  alias Pfu.Repo
  alias Pfu.Tipo

  def index(conn, _params) do
    tipos = Repo.all(Tipo)
    render conn, "index.html", tipos: tipos
  end

  def show(conn, %{"id" => id}) do

    tipo = Repo.get(Tipo, id)
    render conn, "show.html", tipo: tipo
  end

  def new(conn, _params) do
    changeset = Tipo.changeset(%Tipo{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tipo" => tipo_params}) do
    changeset = Tipo.changeset(%Tipo{}, tipo_params)

    case Repo.insert(changeset) do
      {:ok, tipo} ->
        conn
          |> put_flash(:info, "#{tipo.name} created!")
          |> redirect(to: Routes.tipo_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.get(Tipo, id) do
      nil ->
        conn
        |> put_flash(:error, "Tipo not found")
        |> redirect(to: Routes.tipo_path(conn, :index))

      tipo ->
        Repo.delete(tipo)
        conn
        |> put_flash(:info, "Tipo deleted successfully.")
        |> redirect(to: Routes.tipo_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    tipo = Repo.get(Tipo, id)
    changeset = Tipo.changeset(tipo, %{})
    render(conn, "edit.html", tipo: tipo, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tipo" => tipo_params}) do
    tipo = Repo.get(Tipo, id)
    changeset = Tipo.changeset(tipo, tipo_params)

    case Repo.update(changeset) do
      {:ok, tipo} ->
        conn
        |> put_flash(:info, "Tipo updated successfully.")
        |> redirect(to: Routes.tipo_path(conn, :show, tipo))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tipo: tipo, changeset: changeset)
    end
  end
end
