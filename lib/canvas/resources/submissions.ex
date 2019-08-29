defmodule Canvas.Resources.Submissions do
  @moduledoc """
  Provides functions to interact with the
  [enrollment term endpoints](https://canvas.instructure.com/doc/api/enrollment_terms).
  """

  alias Canvas.{Client, Listing, Response}
  alias Canvas.Resources.{Assignment, Course, Submission}

  def submit_an_assignment() do
  end

  @doc """
  Retrieve a paginated list of all existing submissions for an assignment.

  See:
  - https://canvas.instructure.com/doc/api/accounts.html#method.accounts.courses_api

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.EnrollmentTerms.list_enrollment_terms(client, :course, 101, 12345)
      {:ok, response} = Canvas.Resources.EnrollmentTerms.list_enrollment_terms(client, :course, 101, 12345, per_page: 20, page: 2)
      {:ok, response} = Canvas.Resources.EnrollmentTerms.list_enrollment_terms(client, :section, 1234, 12345)

  """
  @spec list_assignment_submissions(
          Client.t(),
          atom,
          String.t() | integer,
          String.t() | integer,
          Keyword.t()
        ) ::
          {:ok | :error, Response.t()}
  def list_assignment_submissions(client, by, id, assignment_id, options \\ [])

  def list_assignment_submissions(client, :course, course_id, assignment_id, options) do
    url = Client.versioned("/courses/#{course_id}/assignments/#{assignment_id}/submissions")
    _list_assignment_submissions(client, url, options)
  end

  def list_assignment_submissions(client, :section, section_id, assignment_id, options) do
    url = Client.versioned("/sections/#{section_id}/assignments/#{assignment_id}/submissions")
    _list_assignment_submissions(client, url, options)
  end

  defp _list_assignment_submissions(client, url, options) do
    Listing.get(client, url, options)
    |> Response.parse([%Submission{assignment: %Assignment{}, course: %Course{}}])
  end

  @doc """
  List all submissions for an assignment automatically paginating if necessary.

  This function will automatically page through all pages, returning all assignments.

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Submissions.all_assignment_submissions(client, :course, 101, 12345)

  """
  @spec all_assignment_submissions(Client.t(), atom, String.t() | integer, Keyword.t()) ::
          {:ok, list(%Submission{})} | {:error, Response.t()}
  def all_assignment_submissions(client, by, id, assignment_id, options \\ []) do
    Listing.get_all(__MODULE__, :list_assignment_submissions, [
      client,
      by,
      id,
      assignment_id,
      options
    ])
  end

  def list_submissions_for_multiple_assignments() do
  end

  def get_a_single_submissionupload_a_file() do
  end

  def grade_or_comment_on_a_submission() do
  end

  def list_gradeable_students() do
  end

  def list_multiple_assignments_gradeable_students() do
  end

  def grade_or_comment_on_multiple_submissions() do
  end

  def mark_submission_as_read() do
  end

  def mark_submission_as_unreadsubmission_summary() do
  end
end
