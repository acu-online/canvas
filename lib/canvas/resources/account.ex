defmodule Canvas.Resources.Account do
  @moduledoc """
  Represents an Account.

  See:
  - https://canvas.instructure.com/doc/api/accounts
  - https://canvas.instructure.com/doc/api/accounts#Account
  """

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          uuid: String.t(),
          parent_account_id: integer,
          root_account_id: integer,
          default_storage_quota_mb: integer,
          default_user_storage_quota_mb: integer,
          default_group_storage_quota_mb: integer,
          default_time_zone: String.t(),
          sis_account_id: String.t(),
          integration_id: String.t(),
          sis_import_id: integer,
          lti_guid: String.t(),
          workflow_state: String.t()
        }

  defstruct ~w(id name uuid parent_account_id root_account_id default_storage_quota_mb
               default_user_storage_quota_mb default_group_storage_quota_mb default_time_zone
               sis_account_id integration_id sis_import_id lti_guid workflow_state)a
end
