module Api::V1::Companies
  class SubmissionsController < ApplicationController
    def create
      company_submission = CompanySubmissionForm.new(company_submission_params).call

      company_submission.save!

      render json: {
        company_submission: company_submission,
        message: 'Company has been submitted and will be reviewed soon.'
      }
    end

    private

    def company_submission_params
      params.require(:company_submission).permit(
        :name,
        :website,
        tools: [:id, :name],
      )
    end
  end
end
