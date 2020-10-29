class Api::V1::StacksController < ApplicationController
  def create
    company = Company.find(params[:company_id])
    company.stack.create(stack_params)

    head :ok
  end

  def stack_params
    params.require(:stack).map do |p|
      single_stack_params(p)
    end
  end

  def single_stack_params(p = nil)
    (p || params.require(:stack)).permit(
      :tool_id,
      :community,
    )
  end
end
