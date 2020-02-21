defmodule Canvas.Resources.Course do
  @moduledoc """
  Represents an Course.

  See:
  - https://canvas.instructure.com/doc/api/courses
  - https://canvas.instructure.com/doc/api/courses#Course
  """

  @type t :: %__MODULE__{
          id: integer,
          sis_course_id: any,
          uuid: String.t(),
          integration_id: any,
          sis_import_id: integer,
          name: String.t(),
          course_code: String.t(),
          workflow_state: String.t(),
          account_id: integer,
          root_account_id: integer,
          enrollment_term_id: integer,
          grading_standard_id: integer,
          created_at: String.t(),
          start_at: String.t(),
          end_at: String.t(),
          locale: String.t(),
          enrollments: any,
          total_students: integer,
          calendar: any,
          default_view: String.t(),
          syllabus_body: String.t(),
          needs_grading_count: integer,
          term: Canvas.Resources.EnrollmentTerm.t(),
          account: Canvas.Resources.Account.t(),
          course_progress: any,
          apply_assignment_group_weights: boolean,
          permissions: any,
          is_public: boolean,
          is_public_to_auth_users: boolean,
          public_syllabus: boolean,
          public_syllabus_to_auth: boolean,
          public_description: String.t(),
          storage_quota_mb: integer,
          storage_quota_used_mb: integer,
          hide_final_grades: boolean,
          license: String.t(),
          allow_student_assignment_edits: boolean,
          allow_wiki_comments: boolean,
          allow_student_forum_attachments: boolean,
          open_enrollment: boolean,
          self_enrollment: boolean,
          restrict_enrollments_to_course_dates: boolean,
          course_format: String.t(),
          access_restricted_by_date: boolean,
          time_zone: String.t(),
          blueprint: boolean,
          blueprint_restrictions: any,
          blueprint_restrictions_by_object_type: any
        }

  defstruct ~w(id sis_course_id uuid integration_id sis_import_id name course_code
               workflow_state account_id root_account_id enrollment_term_id grading_standard_id
               created_at start_at end_at locale enrollments total_students calendar
               default_view syllabus_body needs_grading_count term account course_progress
               apply_assignment_group_weights permissions is_public is_public_to_auth_users
               public_syllabus public_syllabus_to_auth public_description storage_quota_mb
               storage_quota_used_mb hide_final_grades license allow_student_assignment_edits
               allow_wiki_comments allow_student_forum_attachments open_enrollment
               self_enrollment restrict_enrollments_to_course_dates course_format
               access_restricted_by_date time_zone blueprint blueprint_restrictions
               blueprint_restrictions_by_object_type)a
end
