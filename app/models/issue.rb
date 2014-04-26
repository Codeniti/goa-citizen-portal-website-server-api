class Issue < ActiveRecord::Base
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
end
