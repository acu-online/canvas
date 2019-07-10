defmodule Canvas.Resources.Accounts do
  @moduledoc """
  Provides functions to interact with the
  [assignment endpoints](https://canvas.instructure.com/doc/api/assignments).
  """

  alias Canvas.{Client, Listing, Response}
  alias Canvas.Resources.{Account, Course}

  def list_accounts() do
  end

  def list_accounts_for_course_admins() do
  end

  def get_a_single_account() do
  end

  def permissions() do
  end

  def get_the_subaccounts_of_an_account() do
  end

  def get_the_terms_of_service() do
  end

  def get_help_links() do
  end

  @doc """
  Retrieve a paginated list of courses in this account.

  See:
  - https://canvas.instructure.com/doc/api/accounts.html#method.accounts.courses_api

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Accounts.list_active_courses_in_an_account(client, account_id = 1)
      {:ok, response} = Canvas.Resources.Accounts.list_active_courses_in_an_account(client, account_id = 1, per_page: 50, page: 4)

  """
  @spec list_active_courses_in_an_account(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok | :error, Response.t()}
  def list_active_courses_in_an_account(client, account_id, options \\ []) do
    url = Client.versioned("/accounts/#{account_id}/courses")

    Listing.get(client, url, options)
    |> Response.parse([%Course{}])
  end

  @doc """
  List all active courses in an account automatically paginating if necessary.

  This function will automatically page through all pages, returning all assignments.

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Accounts.all_active_courses_in_an_account(client, account_id = 1)

  """
  @spec all_active_courses_in_an_account(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok | :error, Response.t()}
  def all_active_courses_in_an_account(client, account_id, options \\ []) do
    Listing.get_all(__MODULE__, :list_active_courses_in_an_account, [client, account_id, options])
  end

  def update_an_account() do
  end

  def delete_a_user_from_the_root_account() do
  end
end
