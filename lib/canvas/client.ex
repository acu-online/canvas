defmodule Canvas.Client do
  require Logger

  @default_base_url Application.get_env(:canvas, :base_url)
  @default_user_agent "canvas-elixir/#{Application.get_env(:canvas, :version)}"

  @api_version "v1"

  defstruct access_token: nil, base_url: @default_base_url, user_agent: nil
  @type t :: %__MODULE__{access_token: String.t(), base_url: String.t(), user_agent: String.t()}

  @type headers :: [{binary, binary}] | %{binary => binary}
  @type body :: binary | {:form, [{atom, any}]} | {:file, binary}

  @doc """
  Prepends the correct API version to path.

  ## Examples

  iex> Canvas.Client.versioned "/accounts"
  "/api/v1/accounts"

  """
  @spec versioned(String.t()) :: String.t()
  def versioned(path) do
    "/api/" <> @api_version <> path
  end

  @doc """
  Returns the representation of an empty body in a request.

  ## Examples
  iex> Canvas.Client.empty_body()
  nil

  """
  @spec empty_body :: nil
  def empty_body, do: nil

  @doc """
  Issues a GET request to the given url.
  """
  @spec get(Client.t(), binary, Keyword.t()) ::
          {:ok | :error, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
  def get(client, url, options \\ []), do: execute(client, :get, url, empty_body(), options)

  @doc """
  Issues a POST request to the given url.
  """
  @spec post(Client.t(), binary, body, Keyword.t()) ::
          {:ok | :error, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
  def post(client, url, body, options \\ []), do: execute(client, :post, url, body, options)

  @doc """
  Issues a PUT request to the given url.
  """
  @spec put(Client.t(), binary, body, Keyword.t()) ::
          {:ok | :error, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
  def put(client, url, body, options \\ []), do: execute(client, :put, url, body, options)

  @doc """
  Issues a PATCH request to the given url.
  """
  @spec patch(Client.t(), binary, body, Keyword.t()) ::
          {:ok | :error, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
  def patch(client, url, body, options \\ []), do: execute(client, :patch, url, body, options)

  @doc """
  Issues a DELETE request to the given url.
  """
  @spec delete(Client.t(), binary, Keyword.t()) ::
          {:ok | :error, HTTPoison.Response.t() | HTTPoison.AsyncResponse.t()}
  def delete(client, url, options \\ []), do: execute(client, :delete, url, empty_body(), options)

  def execute(client, method, url, body \\ "", all_options \\ []) do
    {headers, options} = split_headers_options(client, all_options)
    {headers, body} = process_request_body(headers, body)
    base_options = [recv_timeout: 30000]

    Logger.debug("[canvas] #{format_http_method(method)} #{url(client, url)} #{inspect(options)}")

    HTTPoison.request!(
      method,
      url(client, url),
      body,
      headers,
      Keyword.merge(base_options, options)
    )
    |> check_response
  end

  defp split_headers_options(client, all_options) do
    default_headers = %{
      "Accept" => "application/json",
      "User-Agent" => format_user_agent(client.user_agent),
      "Authorization" => "Bearer #{client.access_token}"
    }

    {headers, options} = Keyword.pop(all_options, :headers)

    case headers do
      nil -> {default_headers, options}
      headers -> {Enum.into(headers, default_headers), options}
    end
  end

  # Builds the final user agent to use for HTTP requests.
  #
  # If no custom user agent is provided, the default user agent is used.
  #
  #     canvas-elixir/0.0.1
  #
  # If a custom user agent is provided, the final user agent is the combination
  # of the custom user agent prepended by the default user agent.
  #
  #     canvas-elixir/0.0.1 customAgentFlag
  #
  defp format_user_agent(nil), do: @default_user_agent

  defp format_user_agent(custom_agent) do
    "#{@default_user_agent} #{custom_agent}"
  end

  # Extracts a specific {"Name", "Value"} header tuple.
  defp get_header(headers, name) do
    Enum.find(headers, fn {key, _} -> key == name end)
  end

  defp process_request_body(headers, nil), do: {headers, []}
  defp process_request_body(headers, body) when is_binary(body), do: {headers, body}

  defp process_request_body(headers, body) do
    case get_header(headers, "Accept") do
      {_, "application/json"} ->
        {Map.put(headers, "Content-Type", "application/json"), Poison.encode!(body)}

      _ ->
        {headers, body}
    end
  end

  defp url(%Canvas.Client{base_url: base_url}, path) do
    base_url <> path
  end

  defp check_response(http_response) do
    case http_response.status_code do
      i when i in 200..299 -> {:ok, http_response}
      404 -> {:error, Canvas.NotFoundError.new(http_response)}
      _ -> {:error, Canvas.RequestError.new(http_response)}
    end
  end

  defp format_http_method(method) when is_atom(method),
    do: format_http_method(Atom.to_string(method))

  defp format_http_method(method) when is_binary(method), do: String.upcase(method)
end
