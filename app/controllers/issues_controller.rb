class IssuesController < ApplicationController
  before_filter :find_issue, :except => [:index, :create]
  def index
    render :json => {
      :issues => issues_json(filter_issues)
    }
  end

  def get
    render :json => {
      :issue => issue_json(issue)
    }
  end

  def create
    issue = Issue.new(params[:issue].slice*(Issue.accessible_attributes))
    render :json => {
      :issue => issue_json(issue)
    }
  end

  def update
    issue.update_attributes(params[:issue].slice*(Issue.accessible_attributes - [:verified_by]))
    render :json => {
      :issue => issue_json(issue)
    }
  end

  def add_verifying_user
    if params[:user].present? && params[:user][:id].present?
      issue.verified_by = issue.verified_by + params[:user][:id]
      issue.save!
    end
    render :json => {
      :issue => issue_json(issue)
    }
  end

  def remove_verifying_user
    if params[:user].present? && params[:user][:id].present?
      issue.verified_by = issue.verified_by - params[:user][:id]
      issue.save!
    end
    render :json => {
      :issue => issue_json(issue)
    }
  end

  def resolve
    issue.resolve!
    render :json => {
      :issue => issue_json(issue)
    }
  end

  def process_issue
    issue.process!
    render :json => {
      :issue => issue_json(issue)
    }
  end

  def find_issue
    # TODO : handle cases where the issue is not found
    issue = Issue.find(params[:id])
  end

  def filter_issues
    issues = Issue.includes(:comments)

    filters = params.slice(*[:location_tags, :categories, :title, :description, :issues_from, :issues_to, :state])

    if filters.blank?
      return issues
    end

    st = (filters[:issues_from].present? ? Time.zone.parse(filters[:issues_from]) : (Time.zone.now - 10.days)).beginning_of_day
    et = ((filters[:issues_to].present? && Time.zone.parse(filters[:issues_to]) <= Time.zone.now) ? Time.zone.now : Time.zone.parse(filters[:issues_to])).end_of_day

    issues = issues.where("created_at >= ?", st.getutc).where("created_at <= ?", et.getutc)

    if(filters[:location_tags].present?)
      issues = issues.where("location_tags && ARRAY[?]", filters[:location_tags].join(","))
    end

    if(filters[:categories].present?)
      issues = issues.where("categories && ARRAY[?]", filters[:categories].join(","))
    end

    if(filters[:title].present?)
      issues = issues.where("title iname ilike ?", "#{filters[:title]}%")
    end

    if(filters[:description].present?)
      issues = issues.where("description iname ilike ?", "#{filters[:description]}%")
    end

    if(filters[:state].present?)
      issues = issues.where("state = ?", filters[:state])
    end

    return issues
  end

  def issues_json(issues)
    return issues.collect{|i| issue_json(i)}
  end

  def issue_json(issue)
    ret = issue.as_json({
      :except => [:updated_at],
      :comments => {
        :user => {},
        :only => [:description]
      }
    })
    ret[:verified_by] = User.where(:id => ret[:verified_by])
    return ret
  end
end
