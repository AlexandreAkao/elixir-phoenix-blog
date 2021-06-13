defmodule Pfu.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :likes_count, :integer, default: 0
    field :reposts_count, :integer, default: 0
    field :photo_urls, {:array, :string}, default: []
    belongs_to :user, Pfu.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :user_id])
    |> validate_required([:body, :user_id])
    |> validate_length(:body, min: 3, max: 250)
  end
end
