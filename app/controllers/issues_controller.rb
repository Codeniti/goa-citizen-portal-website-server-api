class IssuesController < ApplicationController
  def index
    return Issue.all
  end
end
