class Api::V1::CompaniesController < ApplicationController
  def index
    companies           = Company.all.includes(:tools)
    decorated_companies = CompanyDecorator.decorate_collection(companies, method: :decorate_all)

    render json: { companies: decorated_companies }
  end

  def show
    render json: { company: CompanyDecorator.new(Company.find(params[:id])).decorate }
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
