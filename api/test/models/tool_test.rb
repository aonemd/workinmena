require 'test_helper'

class ToolTest < ActiveSupport::TestCase
  test "validate presence of name" do
    tool = build(:tool, name: nil)

    refute tool.valid?
  end
end
