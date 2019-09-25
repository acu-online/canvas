defmodule Canvas.Resources.Courses do
  @moduledoc """
  Provides functions to interact with the
  [course endpoints](https://canvas.instructure.com/doc/api/courses).
  """

  alias Canvas.{Client, Response}
  alias Canvas.Resources.Course

  def list_your_courses() do
  end

  def list_courses_for_a_user() do
  end

  def create_a_new_course() do
  end

  def upload_a_file() do
  end

  def list_students() do
  end

  def list_users_in_course() do
  end

  def list_recently_logged_in_students() do
  end

  def get_single_user() do
  end

  def preview_processed_html() do
  end

  def course_activity_stream() do
  end

  def course_activity_stream_summary() do
  end

  def course_todo_items() do
  end

  def delete_or_conclude_a_course() do
  end

  def get_course_settings() do
  end

  def update_course_settings() do
  end

  @doc """
  Return information on a single course.

  See:
  - https://canvas.instructure.com/doc/api/courses.html#method.courses.show

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Courses.get_a_single_course(client, 101)

  """
  @spec get_a_single_course(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok | :error, Response.t()}
  def get_a_single_course(client, course_id, options \\ []) do
    url = Client.versioned("/courses/#{course_id}")

    Client.get(client, url, options)
    |> Response.parse(%Course{})
  end

  @doc """
  Return information on a single course within an account.

  See:
  - https://canvas.instructure.com/doc/api/courses.html#method.courses.show

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Courses.get_a_single_course_by_account(client, 1, 101)

  """
  @spec get_a_single_course_by_account(
          Client.t(),
          String.t() | integer,
          String.t() | integer,
          Keyword.t()
        ) ::
          {:ok | :error, Response.t()}
  def get_a_single_course_by_account(client, account_id, course_id, options \\ []) do
    url = Client.versioned("/accounts/#{account_id}/courses/#{course_id}")

    Client.get(client, url, options)
    |> Response.parse(%{"data" => %Course{}})
  end

  def update_a_course() do
  end

  def update_courses() do
  end

  def reset_a_course() do
  end

  def get_effective_due_dates() do
  end

  def permissions() do
  end

  def get_course_copy_status() do
  end

  def copy_course_content() do
  end
end
