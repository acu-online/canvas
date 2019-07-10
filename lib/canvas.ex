defmodule Canvas do
  defmodule Error do
    def decode(body) do
      case Poison.decode(body) do
        {:ok, result} -> result
        {:error, _} -> %{"message" => "Response body could not be decoded."}
      end
    end
  end

  defmodule RequestError do
    @moduledoc """
    Error raised when an API request fails for an client, a server error or invalid request information.
    """
    alias Canvas.Error
    defexception [:message, :http_response]

    def new(http_response) do
      message = Error.decode(http_response.body) |> Map.get("message")

      %__MODULE__{
        message: "HTTP #{http_response.status_code}: #{message}",
        http_response: http_response
      }
    end
  end

  defmodule NotFoundError do
    @moduledoc """
    Error raised when the target of an API request is not found.
    """
    alias Canvas.Error
    defexception [:message, :http_response]

    def new(http_response) do
      %__MODULE__{
        message: Error.decode(http_response.body) |> Map.get("message"),
        http_response: http_response
      }
    end
  end
end
