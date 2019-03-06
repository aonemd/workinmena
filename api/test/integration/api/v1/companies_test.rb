require 'test_helper'

class Api::V1::CompaniesTest < ActionDispatch::IntegrationTest
  def setup
    create(:company)
  end

  test "#index" do
    get '/api/v1/companies'

    assert_response :success
    assert_equal json_response.keys, ['companies']
    assert_equal json_response['companies'].count, Company.count
  end

  test "#crate successfull" do
    post '/api/v1/companies', params: {
      company: { name: Faker::Name.name }
    }

    assert_response :success
    assert_equal json_response.keys, ['company']
  end

  test "#create unsuccessfully" do
    post '/api/v1/companies', params: {
      company: { name: 'name@' }
    }

    assert_response :bad_request
    assert json_response.keys, ['errors']
  end
end
