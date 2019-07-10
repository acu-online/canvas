defmodule Canvas.ClientTest do
  use TestCase, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Canvas.Client

  test "initialize with defaults" do
    client = %Canvas.Client{}
    assert client.access_token == nil
    assert client.base_url == nil
  end

  describe ".versioned" do
    test "joins path with current api version" do
      assert Canvas.Client.versioned("/accounts") == "/api/v1/accounts"
    end
  end

  describe ".execute" do
    setup do
      client = %Canvas.Client{
        access_token: "i-am-a-token",
        base_url: "https://test.instructure.test"
      }

      url = "#{client.base_url}/api/v1/accounts"
      fixture = ExvcrUtils.response_fixture("accounts/success.http", method: "get", url: url)

      {:ok, client: client, fixture: fixture}
    end

    # test "handles headers defines as a map", %{client: client, fixture: fixture} do
    #   use_cassette :stub, fixture do
    #     {:ok, response} = Canvas.Domains.list_domains(client, "1010", headers: %{page: 2})
    #     assert response.__struct__ == Canvas.Response
    #   end
    # end

    # test "handles headers defines as a list", %{client: client, fixture: fixture} do
    #   use_cassette :stub, fixture do
    #     {:ok, response} =
    #       Canvas.Domains.list_domains(client, "1010", headers: [{"X-Header", "X-Value"}])

    #     assert response.__struct__ == Canvas.Response
    #   end
    # end
  end
end
