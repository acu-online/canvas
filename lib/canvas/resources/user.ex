defmodule Canvas.Resources.User do
  @moduledoc """
  Represents an User.

  See:
  - https://canvas.instructure.com/doc/api/users
  - https://canvas.instructure.com/doc/api/users#User
  """

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          sortable_name: String.t(),
          short_name: String.t(),
          sis_user_id: String.t(),
          sis_import_id: integer,
          integration_id: String.t(),
          login_id: String.t(),
          avatar_url: String.t(),
          enrollments: [Canvas.Resources.Enrollment.t()],
          email: String.t(),
          locale: String.t(),
          last_login: String.t(),
          time_zone: String.t(),
          bio: String.t()
        }

  defstruct ~w(id name sortable_name short_name sis_user_id sis_import_id
               integration_id login_id avatar_url enrollments email locale
               last_login time_zone bio)a
end
