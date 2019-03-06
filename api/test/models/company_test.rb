require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "validate presence of name" do
    company = build(:company, name: nil)

    refute company.valid?
  end

  test "validate format of name doesn't contain @" do
    company = build(:company, name: "hello@")

    refute company.valid?
  end
end
