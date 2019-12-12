defmodule Canvas.Resources.Sections do
  @moduledoc """
  Provides functions to interact with the
  [section endpoints](https://canvas.instructure.com/doc/api/sections).
  """

  alias Canvas.{Client, Listing, Response}
  alias Canvas.Resources.{Enrollment, Section, User}

  @doc """
  Lists the sections in a course.

  See:
  - https://canvas.instructure.com/doc/api/sections#method.sections.index

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, response} = Canvas.Resources.Sections.index(client, 101)
      {:ok, response} = Canvas.Resources.Sections.index(client, 101, per_page: 50, page: 4)

  """
  @spec index(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok | :error, Response.t()}
  def index(client, course_id, options \\ []) do
    url = Client.versioned("/courses/#{course_id}/sections")

    Listing.get(client, url, options)
    |> Response.parse([%Section{students: [%User{enrollments: [%Enrollment{}]}]}])
  end

  @doc """
  List all sections in an course automatically paginating if necessary.

  This function will automatically page through all pages, returning all sections.

  ## Examples:

      client = %Canvas.Client{access_token: "a1b2c3d4", base_url: "https://instructure.test"}
      {:ok, sections} = Canvas.Reources.Sections.all(client, 101)

  """
  @spec all(Client.t(), String.t() | integer, Keyword.t()) ::
          {:ok, list(%Section{})} | {:error, Response.t()}
  def all(client, course_id, options \\ []) do
    Listing.get_all(__MODULE__, :index, [client, course_id, options])
  end

  def create() do
  end

  def crosslist() do
  end

  def uncrosslist() do
  end

  def update() do
  end

  def show() do
  end

  def destroy() do
  end
end
