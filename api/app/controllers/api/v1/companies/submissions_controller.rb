module Api::V1::Companies
  class SubmissionsController < ApplicationController
    def create
      submission = Company::Submission.new(submission_params)
      submission.save!

      render json: { submission: submission }
    end

    private

    def submission_params
      params.require(:company_submission).permit(
        :name,
        :website,
        tool_ids: [],
        unknown_tools: []
      )
    end
  end
end
