defmodule PfuWeb.PostLive.PostComponent do
  use PfuWeb, :live_component

  def render(assigns) do
    ~L"""
      <div id="post-<%= @post.id %>" class="table post">
        <div class="row">
          <div class="column column-10">
            <div class="post-avatar">
              <img src="https://image.flaticon.com/icons/svg/180/180<%= 559 + @post.user_id %>.svg" height="32" alt="<%= @post.user.username %>">
            </div>
          </div>
          <div class="column column-90 post-body">
            <b>@<%= @post.user.username %></b>
            <br/>
            <%= @post.body %>
            <div class="column">
              <%= for url <- @post.photo_urls do %>
                <img src="<%= url %>" height="150" />
              <% end %>
            </div>
          </div>
        </div>

        <%= if @current_user do %>
          <div class="row flipar">
            <div class="column">
              <a href="#" phx-click="like" phx-target="<%= @myself %>">
                <i class="far fa-thumbs-up"></i><%= @post.likes_count %>
              </a>
            </div>
            <div class="column">
              <a href="#" phx-click="repost" phx-target="<%= @myself %>">
                <i class="fas fa-retweet"></i><%= @post.reposts_count %>
              </a>
            </div>
            <%= if @current_user.id==@post.user_id do %>
              <div class="column">
                <%= live_patch to: Routes.post_index_path(@socket, :edit, @post.id) do %>
                  <i class="fa fa-edit"></i>
                <% end %>
                <span>&nbsp;&nbsp;</span>
                <%= link to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Remover?"] do %>
                  <i class="fa fa-trash" onclick="carrega()"></i>
                <% end %>
              </div>
            <% end %>
          </div>
        <% end %>
      </div>

      <script>
      function carrega() {
          window.location.reload();
      }
      </script>
    """
  end

  def handle_event("like", _, socket) do
    Pfu.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end
  def handle_event("repost", _, socket) do
    Pfu.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
