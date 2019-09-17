defmodule Canvas.Resources.Enrollment do
  @moduledoc """
  Represents an Enrollment.

  See:
  - https://canvas.instructure.com/doc/api/enrollments
  - https://canvas.instructure.com/doc/api/enrollments#Enrollment
  """

  @type t :: %__MODULE__{
          id: integer,
          course_id: integer,
          sis_course_id: String.t(),
          course_integration_id: String.t(),
          course_section_id: integer,
          section_integration_id: String.t(),
          sis_account_id: String.t(),
          sis_section_id: String.t(),
          sis_user_id: String.t(),
          enrollment_state: String.t(),
          limit_privileges_to_course_section: boolean,
          sis_import_id: integer,
          root_account_id: integer,
          type: String.t(),
          user_id: integer,
          associated_user_id: integer,
          role: String.t(),
          role_id: integer,
          created_at: String.t(),
          updated_at: String.t(),
          start_at: String.t(),
          end_at: String.t(),
          last_activity_at: String.t(),
          last_attended_at: String.t(),
          total_activity_time: integer,
          html_url: String.t(),
          grades: %{
            html_url: String.t(),
            current_score: number,
            current_grade: String.t(),
            final_score: number,
            final_grade: String.t()
          },
          user: any,
          override_grade: String.t(),
          override_score: number,
          unposted_current_grade: String.t(),
          unposted_final_grade: String.t(),
          unposted_current_score: number,
          unposted_final_score: number,
          has_grading_periods: boolean,
          totals_for_all_grading_periods_option: boolean,
          current_grading_period_title: String.t(),
          current_grading_period_id: integer,
          current_period_override_grade: String.t(),
          current_period_override_score: number,
          current_period_unposted_current_score: number,
          current_period_unposted_final_score: number,
          current_period_unposted_current_grade: String.t(),
          current_period_unposted_final_grade: String.t()
        }

  defstruct ~w(id course_id sis_course_id course_integration_id course_section_id
               section_integration_id sis_account_id sis_section_id sis_user_id
               enrollment_state limit_privileges_to_course_section sis_import_id
               root_account_id type user_id associated_user_id role role_id
               created_at updated_at start_at end_at last_activity_at last_attended_at
               total_activity_time html_url grades user override_grade override_score
               unposted_current_grade unposted_final_grade unposted_current_score
               unposted_final_score has_grading_periods totals_for_all_grading_periods_option
               current_grading_period_title current_grading_period_id
               current_period_override_grade current_period_override_score
               current_period_unposted_current_score current_period_unposted_final_score
               current_period_unposted_current_grade current_period_unposted_final_grade)a
end
