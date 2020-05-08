defmodule Canvas.Resources.Submissions do
  @moduledoc """
  Provides functions to interact with the
  [enrollment term endpoints](https://canvas.instructure.com/doc/api/enrollment_terms).
  """

  alias Canvas.{Client, Listing, Response}
  alias Canvas.Resources.{Assignment, Course, Submission, User}

  def submit_an_assignment() do
  end

  @doc """
  Retrieve a paginated list of all existing submissions for an assignment.

  See:
  https://canvas.instructure.com/doc/api/submissions.html#method.submissions_api.index

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Submissions.list_assignment_submissions(client, :course, 101, 12345)
      {:ok, response} = Canvas.Resources.Submissions.list_assignment_submissions(client, :course, 101, 12345, per_page: 20, page: 2)
      {:ok, response} = Canvas.Resources.Submissions.list_assignment_submissions(client, :section, 1234, 12345)

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
    |> Response.parse([%Submission{assignment: %Assignment{}, course: %Course{}, user: %User{}}])
  end

  @doc """
  List all submissions for an assignment automatically paginating if necessary.

  This function will automatically page through all pages, returning all submissions.

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Submissions.all_assignment_submissions(client, :course, 101, 12345)

  """
  @spec all_assignment_submissions(
          Client.t(),
          atom,
          String.t() | integer,
          String.t() | integer,
          Keyword.t()
        ) ::
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

  @doc """
  A paginated list of all existing submissions for a given set of students and assignments.

  See:
  https://canvas.instructure.com/doc/api/submissions.html#method.submissions_api.for_students

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Submissions.list_submissions_for_multiple_assignments(client, :course, 101, params: [assignment_ids: [97, 98, 99]])
      {:ok, response} = Canvas.Resources.Submissions.list_submissions_for_multiple_assignments(client, :course, 101, params: [student_ids: [1001, 1002], grouped: true])
      {:ok, response} = Canvas.Resources.Submissions.list_submissions_for_multiple_assignments(client, :section, 1234)

  """
  @spec list_submissions_for_multiple_assignments(
          Client.t(),
          atom,
          String.t() | integer,
          Keyword.t()
        ) ::
          {:ok | :error, Response.t()}
  def list_submissions_for_multiple_assignments(client, by, id, options \\ [])

  def list_submissions_for_multiple_assignments(client, :course, course_id, options) do
    url = Client.versioned("/courses/#{course_id}/students/submissions")
    _list_submissions_for_multiple_assignments(client, url, options)
  end

  def list_submissions_for_multiple_assignments(client, :section, section_id, options) do
    url = Client.versioned("/sections/#{section_id}/students/submissions")
    _list_submissions_for_multiple_assignments(client, url, options)
  end

  defp _list_submissions_for_multiple_assignments(client, url, options) do
    format =
      if Keyword.get(options, :params, []) |> Keyword.get(:grouped) do
        [%{submissions: [%Submission{assignment: %Assignment{}, course: %Course{}}]}]
      else
        [%Submission{assignment: %Assignment{}, course: %Course{}, user: %User{}}]
      end

    Listing.get(client, url, options)
    |> Response.parse(format)
  end

  @doc """
  Get a single submission, based on user id.

  See:
  https://canvas.instructure.com/doc/api/submissions.html#method.submissions_api.show

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Submissions.get_a_single_submission(client, :course, 101, 12345, 4321)
      {:ok, response} = Canvas.Resources.Submissions.get_a_single_submission(client, :course, 101, 12345, 4321, include: "submission_comments")
      {:ok, response} = Canvas.Resources.Submissions.get_a_single_submission(client, :section, 1234, 12345, 4321)

  """
  @spec get_a_single_submission(
          Client.t(),
          atom,
          String.t() | integer,
          String.t() | integer,
          String.t() | integer,
          Keyword.t()
        ) ::
          {:ok | :error, Response.t()}
  def get_a_single_submission(client, by, id, assignment_id, user_id, options \\ [])

  def get_a_single_submission(client, :course, course_id, assignment_id, user_id, options) do
    url =
      Client.versioned(
        "/courses/#{course_id}/assignments/#{assignment_id}/submissions/#{user_id}"
      )

    _get_a_single_submission(client, url, options)
  end

  def get_a_single_submission(client, :section, section_id, assignment_id, user_id, options) do
    url =
      Client.versioned(
        "/sections/#{section_id}/assignments/#{assignment_id}/submissions/#{user_id}"
      )

    _get_a_single_submission(client, url, options)
  end

  defp _get_a_single_submission(client, url, options) do
    Listing.get(client, url, options)
    |> Response.parse(%Submission{assignment: %Assignment{}, course: %Course{}, user: %User{}})
  end

  def upload_a_file() do
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
