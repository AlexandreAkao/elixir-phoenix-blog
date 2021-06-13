defmodule PfuWeb.PostLive.Index do
  use PfuWeb, :live_view

  alias Pfu.Timeline
  alias Pfu.Timeline.Post
  alias Pfu.Repo
  alias Pfu.User

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    if connected?(socket), do: Timeline.subscribe()
    socket = assign_new(socket, :current_user, fn -> Repo.get(User, user_id) end)
    config(socket)
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Timeline.subscribe()
    socket = assign_new(socket, :current_user, fn -> nil end)
    config(socket)
  end
  defp config(socket), do: {:ok, assign(socket, :posts, fetch_posts()), temporary_assigns: [posts: []]}

  #Progamado
    @impl true
    def handle_info({:post_created, post}, socket) do
      {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
    end

    def handle_info({:post_updated, post}, socket) do
      {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
    end

    def handle_info({:post_deleted, post}, socket) do
      {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
    end
  # End Programado

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Timeline.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do #programado
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{user_id: socket.assigns.current_user.id})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Timeline.get_post!(id)
    {:ok, _} = Timeline.delete_post(post)

    {:noreply, assign(socket, :posts, fetch_posts())}
  end

  defp fetch_posts do
    Timeline.list_posts()
  end
end
