defmodule Canvas.Listing do
  alias Canvas.Client

  @doc """
  Issues a GET request to the given url processing the listing options first.
  """
  @spec get(Client.t(), binary, Keyword.t()) ::
          {:ok | :error, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
  def get(client, url, options \\ []), do: Client.get(client, url, format(options))

  @known_params ~w(page per_page as_user_id include)a

  @doc """
  Format request options for list endpoints into HTTP params.
  """
  def format(options) do
    {params, options} = Enum.reduce(@known_params, {[], options}, &extract_param/2)

    case params do
      [] ->
        options

      _ ->
        Keyword.merge(options, [params: params], fn _k, v1, v2 -> Keyword.merge(v1, v2) end)
    end
    |> Keyword.update(:params, [], &UriQuery.params(&1, add_indices_to_lists: false))
  end

  defp extract_param(option, {params, options}) do
    case Keyword.get_and_update(options, option, fn _ -> :pop end) do
      {nil, _} ->
        {params, options}

      {value, updated_options} ->
        updated_params = Keyword.put(params, option, value)
        {updated_params, updated_options}
    end
  end

  @first_page 1
  @unkown_pages_left nil

  @doc """
  Iterates over all pages of a listing endpoint and returns the union of all
  the elements of all pages in the form of `{:ok, all_elements}`.  If an
  error occurs it will return the response to the request that failed in the
  form of `{:error, failed_response}`.

  Note that the `params` attribute must include the `options` parameter even
  if it's optional.

  ## Examples

  client = %Canvas.Client{access_token: "a1b2c3d4"}
  Listing.get_all(Canvas.Courses, :list_courses, [client, account_id, []])

  """
  def get_all(module, function, params) do
    get_pages(
      module,
      function,
      params,
      _all = [],
      _page = @first_page,
      _pages_left = @unkown_pages_left
    )
  end

  defp get_pages(_module, _function, _params, all, _page, _pages_left = 0), do: {:ok, all}

  defp get_pages(module, function, params, all, current_page, _pages_left) do
    case apply(module, function, add_page_param(params, current_page)) do
      {:ok, response} ->
        all = all ++ response.data
        next_page = current_page + 1
        remaining = response.pagination.last_page - current_page
        get_pages(module, function, params, all, next_page, remaining)

      {:error, response} ->
        {:error, response}
    end
  end

  defp add_page_param(params, page) do
    arity = Enum.count(params)
    options = Keyword.put(List.last(params), :page, page)
    List.replace_at(params, arity - 1, options)
  end
end
