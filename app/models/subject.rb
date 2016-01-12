class Subject < ActiveRecord::Base

	has_many :pages

=begin
	scope :visible, lamda{where(:visible => true)}
	scope :invisible, lamda{where(:visible => false)}
	# subjects disambiguates, so that the controller is spelled out here
	scope :sorted, lamda{order("subjects.position ASC")}
	scope :newest_first, lamda{order("subjects.created_at DESC")}
	scope :search, lamda{|query|
		where(["name LIKE ?", "%#{query}%"])
	}
=end
end
