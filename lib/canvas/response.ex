defmodule Canvas.Response do
  defstruct ~w(http_response data pagination request_cost rate_limit_remaining)a

  @type t :: %__MODULE__{
          http_response: HTTPoison.Response.t(),
          data: any,
          pagination: Canvas.Response.Pagination,
          request_cost: float,
          rate_limit_remaining: float
        }

  defmodule Pagination do
    defstruct ~w(current_page per_page last_page)a

    @type t :: %__MODULE__{
            current_page: integer,
            per_page: integer,
            last_page: integer
          }

    def extract_pagination(links) when is_binary(links) do
      [current_page, per_page, last_page] = process_link_header(links)

      %__MODULE__{
        current_page: String.to_integer(current_page),
        per_page: String.to_integer(per_page),
        last_page: String.to_integer(last_page)
      }
    end

    alias Canvas.Response.Pagination

    def extract_pagination(_), do: nil

    defp process_link_header(links) do
      regex =
        ~r/<.*page\=(\d+)&per_page\=(\d+).*>; rel=\"current\".*<.*page=(\d+)&.*>; rel=\"last\"/

      Regex.run(regex, links, capture: :all_but_first)
    end
  end

  def parse(response, format \\ nil, data_key \\ nil)
  def parse({:error, http_response}, _format, _data_key), do: {:error, http_response}

  def parse({:ok, http_response}, format, data_key) do
    data = http_response |> decode(format) |> extract_data(data_key)

    {:ok, build_response(http_response, data)}
  end

  defp decode(%HTTPoison.Response{body: ""}, _format), do: nil
  defp decode(%HTTPoison.Response{body: body}, nil), do: Poison.decode!(body)
  defp decode(%HTTPoison.Response{body: body}, format), do: Poison.decode!(body, as: format)

  defp extract_data(data, data_key) when is_map(data), do: Map.get(data, data_key, data)
  defp extract_data(data, _data_key), do: data

  defp build_response(http_response, data) do
    headers = Enum.into(http_response.headers, %{})

    %__MODULE__{
      http_response: http_response,
      data: data,
      pagination: Pagination.extract_pagination(headers["Link"]),
      request_cost: String.to_float(headers["X-Request-Cost"]),
      rate_limit_remaining: String.to_float(headers["X-Rate-Limit-Remaining"])
    }
  end
end
