class User < ActiveRecord::Base
	#EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[@\.]+\z/

	validates_presence_of :email, :full_name, :location, :password
	#validates_confirmation_of :password
	validates_length_of :bio, minium: 30, allow_blank: false
	validates_uniqueness_of :email
	has_secure_password
	#Essa validação pode ser representada da seguinte forma:
	 #validates_format_of :email, with EMAIL_REGEXP
	#validate do 
	#	errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
	#end

end
