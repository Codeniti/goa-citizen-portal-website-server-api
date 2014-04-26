class Issue < ActiveRecord::Base
  has_many :comments
  attr_accessible :title,:description,:location_tags,:verified_by,:categories

  state_machine :initial => :unresolved do 
    ##
    event :resolve do
      transition [:unresolved, :under_process] => :resolved
    end

    ##
    event :process do
      transition :unresolved => :under_process
    end
  end

  def verified_by
    user_ids = self.attributes[:verified_by]
    return User.where(:id => user_ids)
  end
end
