defmodule Canvas.Resources.Submission do
  @moduledoc """
  Represents an Submission.

  See:
  - https://canvas.instructure.com/doc/api/submissions
  - https://canvas.instructure.com/doc/api/submissions#Submission
  """

  @type t :: %__MODULE__{
          assignment_id: integer,
          assignment: Canvas.Resources.Assignment.t(),
          course: Canvas.Resources.Course.t(),
          attempt: integer,
          body: String.t(),
          grade: String.t(),
          grade_matches_current_submission: boolean,
          html_url: String.t(),
          preview_url: String.t(),
          score: float,
          submission_comments: any,
          submission_type: String.t(),
          submitted_at: String.t(),
          url: String.t(),
          user_id: integer,
          grader_id: integer,
          graded_at: String.t(),
          user: any,
          late: boolean,
          assignment_visible: boolean,
          excused: boolean,
          missing: boolean,
          late_policy_status: String.t(),
          points_deducted: float,
          seconds_late: integer,
          workflow_state: String.t(),
          extra_attempts: integer,
          anonymous_id: String.t()
        }

  defstruct ~w(assignment_id assignment course attempt body grade grade_matches_current_submission
               html_url preview_url score submission_comments submission_type submitted_at url user_id
               grader_id graded_at user late assignment_visible excused missing late_policy_status
               points_deducted seconds_late workflow_state extra_attempts anonymous_id)a
end
