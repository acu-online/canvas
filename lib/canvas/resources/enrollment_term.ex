defmodule Canvas.Resources.EnrollmentTerm do
  @moduledoc """
  Represents an EnrollmentTerm.

  See:
  - https://canvas.instructure.com/doc/api/enrollment_terms
  - https://canvas.instructure.com/doc/api/enrollment_terms#EnrollmentTerm
  """

  @type t :: %__MODULE__{
          id: integer,
          sis_term_id: String.t(),
          sis_import_id: integer,
          name: String.t(),
          start_at: String.t(),
          end_at: String.t(),
          workflow_state: String.t(),
          overrides: any
        }

  defstruct ~w(id sis_term_id sis_import_id name start_at end_at workflow_state overrides)a
end
