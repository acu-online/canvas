defmodule Canvas.Resources.Assignment do
  @moduledoc """
  Represents an Assignment.

  See:
  - https://canvas.instructure.com/doc/api/assignments
  - https://canvas.instructure.com/doc/api/assignments#Assignment
  """

  @type t :: %__MODULE__{
          id: integer,
          name: String.t(),
          description: String.t(),
          created_at: String.t(),
          updated_at: String.t(),
          due_at: String.t(),
          lock_at: String.t(),
          unlock_at: String.t(),
          has_overrides: boolean,
          # all_dates: null,
          all_dates: any,
          course_id: integer,
          html_url: String.t(),
          submissions_download_url: String.t(),
          assignment_group_id: integer,
          due_date_required: boolean,
          # allowed_extensions: ["docx", "ppt"],
          allowed_extensions: any,
          max_name_length: integer,
          turnitin_enabled: boolean,
          vericite_enabled: boolean,
          # turnitin_settings: null,
          turnitin_settings: any,
          grade_group_students_individually: boolean,
          # external_tool_tag_attributes: null,
          external_tool_tag_attributes: any,
          peer_reviews: boolean,
          automatic_peer_reviews: boolean,
          peer_review_count: integer,
          peer_reviews_assign_at: String.t(),
          intra_group_peer_reviews: boolean,
          group_category_id: integer,
          needs_grading_count: integer,
          # needs_grading_count_by_section: [{"section_id":"123456","needs_grading_count":5}, {"section_id":"654321","needs_grading_count":0}],
          needs_grading_count_by_section: any,
          position: integer,
          post_to_sis: boolean,
          integration_id: String.t(),
          integration_data: String.t(),
          # muted: null,
          muted: any,
          points_possible: integer,
          # submission_types: ["online_text_entry"],
          submission_types: any,
          has_submitted_submissions: boolean,
          grading_type: String.t(),
          # grading_standard_id: null,
          grading_standard_id: any,
          published: boolean,
          unpublishable: boolean,
          only_visible_to_overrides: boolean,
          locked_for_user: boolean,
          # lock_info: null,
          lock_info: any,
          lock_explanation: String.t(),
          quiz_id: integer,
          anonymous_submissions: boolean,
          # discussion_topic: null,
          discussion_topic: any,
          freeze_on_copy: boolean,
          frozen: boolean,
          frozen_attributes: [String.t()],
          # submission: null,
          submission: any,
          use_rubric_for_grading: boolean,
          # rubric_settings: "{"points_possible"=>12}",
          rubric_settings: any,
          # rubric: null,
          rubric: any,
          assignment_visibility: [integer],
          # overrides: null,
          overrides: any,
          omit_from_final_grade: boolean,
          moderated_grading: boolean,
          grader_count: integer,
          final_grader_id: integer,
          grader_comments_visible_to_graders: boolean,
          graders_anonymous_to_graders: boolean,
          grader_names_visible_to_final_grader: boolean,
          anonymous_grading: boolean,
          allowed_attempts: integer
        }

  defstruct ~w(id name description created_at updated_at due_at lock_at unlock_at has_overrides
               all_dates course_id html_url submissions_download_url assignment_group_id
               due_date_required allowed_extensions max_name_length turnitin_enabled
               vericite_enabled turnitin_settings grade_group_students_individually
               external_tool_tag_attributes peer_reviews automatic_peer_reviews peer_review_count
               peer_reviews_assign_at intra_group_peer_reviews group_category_id
               needs_grading_count needs_grading_count_by_section position post_to_sis
               integration_id integration_data muted points_possible submission_types
               has_submitted_submissions grading_type grading_standard_id published unpublishable
               only_visible_to_overrides locked_for_user lock_info lock_explanation quiz_id
               anonymous_submissions discussion_topic freeze_on_copy frozen frozen_attributes
               submission use_rubric_for_grading rubric_settings rubric assignment_visibility
               overrides omit_from_final_grade moderated_grading grader_count final_grader_id
               grader_comments_visible_to_graders graders_anonymous_to_graders
               grader_names_visible_to_final_grader anonymous_grading allowed_attempts)a
end
