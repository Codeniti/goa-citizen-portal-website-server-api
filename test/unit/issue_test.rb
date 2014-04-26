require 'test_helper'
require 'factory_girl'

class IssueTest < ActiveSupport::TestCase
  test "sanity" do
    @issue = nil
    assert_nothing_raised do
      @issue = FactoryGirl.create(:issue, {
        :title => "hello there",
        :description => "Booyah!",
        :location_tags => ["goa", "panjim", "taleigao"],
        :categories => ["public", "transport"]
      })
    end
    assert(@issue.unresolved?, "Issue should be created unresolved by default")
  end
end
