class Api::V1::CompaniesController < ApplicationController
  def index
    render json: { companies: CompanyDecorator.decorate_collection(Company.all) }
  end
end
