class Api::V1::CompaniesController < ApplicationController
  def index
    companies = if params[:limit]
                  _limit = Integer(params[:limit])
                  Company.includes(:tools).first(_limit)
                else
                  Company.all.includes(:tools)
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
