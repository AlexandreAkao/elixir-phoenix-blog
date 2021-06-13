defmodule PfuWeb.UserController do
  use PfuWeb, :controller
  alias Pfu.Repo
  alias Pfu.User
  alias Pfu.Tipo
  alias PfuWeb.Auth

  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
    tipos = Repo.all(Tipo) |> Enum.map(&{&1.name, &1.id})

    usuarios = Repo.all(User)
    render(conn, "index.html", users: usuarios, tipos: tipos)
  end

  def show(conn, %{"id" => id}) do
    tipos = Repo.all(Tipo) |> Enum.map(&{&1.name, &1.id})

    usuario = Repo.get(User, id)
    render(conn, "show.html", user: usuario, tipos: tipos)
  end

  def new(conn, _params) do
    tipos = Repo.all(Tipo) |> Enum.map(&{&1.name, &1.id})

    changeset = User.changeset(%User{}, %{})
    render(conn, "new.html", changeset: changeset, tipos: tipos)
  end

    ## Explixar na proxima aula
  def create(conn, %{"user" => user_params}) do
    tipos = Repo.all(Tipo) |> Enum.map(&{&1.name, &1.id})

    changeset = User.changeset(%User{}, user_params)
    #nao trata erro:
    #{:ok, user} = Repo.insert(changeset)
    #conn
    #  |> put_flash(:info, "#{user.name} created!")
    #  |> redirect(to: Helpers.user_path(conn, :index))
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
          |> Auth.login(user)
          |> put_flash(:info, "#{user.name} created!")
          |> redirect(to: Routes.user_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, tipos: tipos)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Repo.get(User, id) do
      nil ->
        conn
        |> put_flash(:error, "User not found")
        |> redirect(to: Routes.user_path(conn, :index))

      user ->
        Repo.delete(user)
        conn
        |> put_flash(:info, "User deleted successfully.")
        |> redirect(to: Routes.user_path(conn, :index))
    end
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, %{})
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end


end
