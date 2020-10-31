class Api::V1::StacksController < ApplicationController
  def create
    stack_entries = find_company.stack.create(stack_params)

    render json: { stack_entries: StackEntryDecorator.decorate_collection(stack_entries) }
  end

  def endorse
    find_stack_entry.increment!(:community_endorsements)

    head :ok
  end

  def stack_params
    params.require(:stack).map do |p|
      single_stack_params(p)
    end
  end

  def single_stack_params(p = nil)
    (p || params.require(:stack_entry)).permit(
      :tool_id,
      :community,
    )
  end

  def find_stack_entry
    find_company.stack.find(params[:id])
  end

  def find_company
    Company.find(params[:company_id])
  end
end
