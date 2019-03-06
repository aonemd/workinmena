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
end
