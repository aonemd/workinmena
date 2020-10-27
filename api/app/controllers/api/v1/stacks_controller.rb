class Api::V1::StacksController < ApplicationController
  def create
    company = Company.find(params[:company_id])
    stack   = company.stack.new(stack_params)

    stack.save!

    render json: { stack: stack }
  end

  def stack_params
    params.require(:stack).permit(
      :tool_id,
      :community,
    )
  end
end
