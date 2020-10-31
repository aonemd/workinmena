class Api::V1::CompaniesController < ApplicationController
  def index
    scope = Company.includes(:tools, :company_popular_tool)
    companies = if params[:limit]
                  _limit = Integer(params[:limit])
                  scope.first(_limit)
                else
                  scope.all
                end

    decorated_companies = CompanyDecorator.decorate_collection(companies, method: :decorate_all)

    render json: { companies: decorated_companies }
  end

  def show
    company           = Company.includes(:stack, :tools, :categories).find(params[:id])
    decorated_company = CompanyDecorator.new(company).decorate

    render json: { company: decorated_company }
  end

  def create
    company = Company.new(company_params)
    company.save!
    render json: { company: CompanyDecorator.new(company).decorate }
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
