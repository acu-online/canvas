defmodule Canvas.Resources.Users do
  @moduledoc """
  Provides functions to interact with the
  [course endpoints](https://canvas.instructure.com/doc/api/users).
  """

  alias Canvas.{Client, Listing, Response}
  alias Canvas.Resources.User

  @doc """
  A paginated list of of users associated with this account.

  See:
  - https://canvas.instructure.com/doc/api/users#method.users.index

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Users.list_users_in_account(client, account_id = 1)

  """
  @spec list_users_in_account(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok | :error, Response.t()}
  def list_users_in_account(client, account_id, options \\ []) do
    url = Client.versioned("/accounts/#{account_id}/users")

    Listing.get(client, url, options)
    |> Response.parse([%User{}])
  end

  @doc """
  A paginated list of of users associated with this account.

  See:
  - https://canvas.instructure.com/doc/api/users#method.users.index

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Users.all_users_in_account(client, account_id = 1)

  """
  @spec all_users_in_account(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok, list(%User{})} | {:error, Response.t()}
  def all_users_in_account(client, account_id, options \\ []) do
    Listing.get_all(__MODULE__, :list_users_in_account, [client, account_id, options])
  end

  def list_the_activity_stream() do
  end

  def activity_stream_summary() do
  end

  def list_the_todo_items() do
  end

  def list_counts_for_todo_items() do
  end

  def list_upcoming_assignments_calendar_events() do
  end

  def list_missing_submissions() do
  end

  def hide_a_stream_item() do
  end

  def hide_all_stream_items() do
  end

  def upload_a_file() do
  end

  def show_user_details() do
  end

  def create_a_user() do
  end

  def self_register_a_user() do
  end

  def update_user_settings() do
  end

  def get_custom_colors() do
  end

  def get_custom_color() do
  end

  def update_custom_color() do
  end

  def get_dashboard_positions() do
  end

  def update_dashboard_positions() do
  end

  def edit_a_user() do
  end

  def merge_user_into_another_user() do
  end

  def split_merged_users_into_separate_users() do
  end

  def get_a_pandata_events_jwt_token_and_its_expiration_date() do
  end

  def get_a_users_most_recently_graded_submissions() do
  end

  def get_user_profilelist_avatar_options() do
  end

  def list_user_page_views() do
  end
end
