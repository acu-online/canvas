defmodule Canvas.Resources.Enrollments do
  @moduledoc """
  Provides functions to interact with the
  [enrollment term endpoints](https://canvas.instructure.com/doc/api/enrollments).
  """

  alias Canvas.{Client, Listing, Response}
  alias Canvas.Resources.{Enrollment, User}

  @doc """
  Depending on the URL given, return a paginated list of either
  (1) all of the enrollments in a course,
  (2) all of the enrollments in a section or
  (3) all of a user's enrollments.

  This includes student, teacher, TA, and observer enrollments. 

  If a user has multiple enrollments in a context (e.g. as a teacher and a student or in multiple
  course sections), each enrollment will be listed separately.

  note: Currently, only a root level admin user can return other users' enrollments. 
  A user can, however, return his/her own enrollments.

  See:
  - https://canvas.instructure.com/doc/api/enrollments#method.enrollments_api.index

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Enrollments.list_enrollments(client, :course, 101)
      {:ok, response} = Canvas.Resources.Enrollments.list_enrollments(client, :course, 101, per_page: 20, page: 2)
      {:ok, response} = Canvas.Resources.Enrollments.list_enrollments(client, :section, 1234)
      {:ok, response} = Canvas.Resources.Enrollments.list_enrollments(client, :user, 123)

  """
  @spec list_enrollments(Client.t(), atom, String.t() | integer, Keyword.t()) ::
          {:ok | :error, Response.t()}
  def list_enrollments(client, by, id, options \\ [])

  def list_enrollments(client, :course, id, options) do
    url = Client.versioned("/courses/#{id}/enrollments")
    _list_enrollments(client, url, options)
  end

  def list_enrollments(client, :section, id, options) do
    url = Client.versioned("/sections/#{id}/enrollments")
    _list_enrollments(client, url, options)
  end

  def list_enrollments(client, :user, id, options) do
    url = Client.versioned("/users/#{id}/enrollments")
    _list_enrollments(client, url, options)
  end

  defp _list_enrollments(client, url, options) do
    Listing.get(client, url, options)
    |> Response.parse([%Enrollment{user: %User{}}])
  end

  @doc """
  List all enrollments automatically paginating if necessary.

  This function will automatically page through all pages, returning all enrollments.

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Enrollments.all_enrollments(client, :course, 101)

  """
  @spec all_enrollments(Client.t(), atom, String.t() | integer, Keyword.t()) ::
          {:ok, list(%Enrollment{})} | {:error, Response.t()}
  def all_enrollments(client, by, id, options \\ []) do
    Listing.get_all(__MODULE__, :list_enrollments, [client, by, id, options])
  end

  def get_enrollment() do
  end

  def enroll_by_course() do
  end

  def enroll_by_section() do
  end

  def conclude_deactivate_delete() do
  end

  def accept() do
  end

  def reject() do
  end

  def reactivate() do
  end

  def last_attended() do
  end
end
