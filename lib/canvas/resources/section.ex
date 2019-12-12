defmodule Canvas.Resources.Section do
  @moduledoc """
  Represents an Section.

  See:
  - https://canvas.instructure.com/doc/api/sections
  - https://canvas.instructure.com/doc/api/sections#Section
  """

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          sis_section_id: String.t(),
          integration_id: String.t(),
          sis_import_id: integer,
          course_id: integer,
          sis_course_id: String.t(),
          start_at: String.t(),
          end_at: String.t(),
          restrict_enrollments_to_section_dates: boolean,
          nonxlist_course_id: integer,
          total_students: integer,
          students: [Canvas.Resources.User.t()]
        }

  defstruct ~w(id name sis_section_id integration_id sis_import_id course_id sis_course_id
               start_at end_at restrict_enrollments_to_section_dates nonxlist_course_id
               total_students students)a
end
