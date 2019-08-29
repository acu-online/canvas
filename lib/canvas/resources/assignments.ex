defmodule Canvas.Resources.Assignments do
  @moduledoc """
  Provides functions to interact with the
  [assignment endpoints](https://canvas.instructure.com/doc/api/assignments).
  """

  alias Canvas.{Client, Listing, Response}
  alias Canvas.Resources.Assignment

  def delete_an_assignment() do
  end

  @doc """
  Lists the assignments in a course.

  See:
  - https://canvas.instructure.com/doc/api/assignments#method.assignments_api.index

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Assignments.list_assignments(client, course_id = 101)
      {:ok, response} = Canvas.Resources.Assignments.list_assignments(client, course_id = 101, per_page: 50, page: 4)

  """
  @spec list_assignments(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok | :error, Response.t()}
  def list_assignments(client, course_id, options \\ []) do
    url = Client.versioned("/courses/#{course_id}/assignments")

    Listing.get(client, url, options)
    |> Response.parse([%Assignment{}])
  end

  @doc """
  List all assignments in an course automatically paginating if necessary.

  This function will automatically page through all pages, returning all assignments.

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, assignments} = Canvas.Reources.Assignments.all_assignments(client, course_id = 101)

  """
  @spec all_assignments(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok, list(%Assignment{})} | {:error, Response.t()}
  def all_assignments(client, course_id, options \\ []) do
    Listing.get_all(__MODULE__, :list_assignments, [client, course_id, options])
  end

  def list_assignments_for_assignment_group() do
  end

  def list_assignments_for_user() do
  end

  def get_a_single_assignment() do
  end

  def create_an_assignment() do
  end

  def edit_an_assignment() do
  end
end
