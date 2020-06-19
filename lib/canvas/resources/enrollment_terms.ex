defmodule Canvas.Resources.EnrollmentTerms do
  @moduledoc """
  Provides functions to interact with the
  [enrollment term endpoints](https://canvas.instructure.com/doc/api/enrollment_terms).
  """

  alias Canvas.{Client, Listing, Response}
  alias Canvas.Resources.EnrollmentTerm

  def create_enrollment_term() do
  end

  def update_enrollment_term() do
  end

  def delete_enrollment_term() do
  end

  @doc """
  Retrieve a paginated list of terms in this account.

  See:
  - https://canvas.instructure.com/doc/api/accounts.html#method.accounts.courses_api

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.EnrollmentTerms.list_enrollment_terms(client, account_id = 1)
      {:ok, response} = Canvas.Resources.EnrollmentTerms.list_enrollment_terms(client, account_id = 1, per_page: 20, page: 2)

  """
  @spec list_enrollment_terms(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok | :error, Response.t()}
  def list_enrollment_terms(client, account_id, options \\ []) do
    url = Client.versioned("/accounts/#{account_id}/terms")

    Listing.get(client, url, options)
    |> Response.parse(%{"enrollment_terms" => [%EnrollmentTerm{}]}, :enrollment_terms)
  end

  @doc """
  List all terms in an account automatically paginating if necessary.

  This function will automatically page through all pages, returning all assignments.

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.EnrollmentTerms.all_enrollment_terms(client, account_id = 1)

  """
  @spec all_enrollment_terms(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok, list(%EnrollmentTerm{})} | {:error, Response.t()}
  def all_enrollment_terms(client, account_id, options \\ []) do
    Listing.get_all(__MODULE__, :list_enrollment_terms, [client, account_id, options])
  end

  @doc """
  Retrieves the details for an enrollment term in the account. Includes overrides by default.

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.EnrollmentTerms.get_enrollment_term(client, account_id = 1, term_id = 10)

  """
  @spec get_enrollment_term(Client.t(), String.t() | integer, String.t() | integer, Keyword.t()) ::
          {:ok, %EnrollmentTerm{}} | {:error, Response.t()}
  def get_enrollment_term(client, account_id, id, options \\ []) do
    url = Client.versioned("/accounts/#{account_id}/terms/#{id}")

    Listing.get(client, url, options)
    |> Response.parse(%EnrollmentTerm{})
  end
end
