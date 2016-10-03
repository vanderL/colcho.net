class User < ActiveRecord::Base

	has_many :rooms, dependent: :destroy
	has_many :reviews, dependent: :destroy
	has_many :reviewed_rooms, through: :reviews, source: :room

	scope :most_recent, -> { order('created_at DESC') }
	scope :from_fortal, -> { where(location: 'fortaleza Ce') }
	scope :confirmed, -> {where.not(confirmed_at: nil)}
	#EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[@\.]+\z/

	validates_presence_of :email, :full_name, :location
	#validates_confirmation_of :password
	validates_length_of :bio, minium: 30, allow_blank: false
	validates_uniqueness_of :email
	has_secure_password

	before_create do |user|
		user.confirmation_token = SecureRandom.urlsafe_base64
	end

	def confirm!
		return if confirmed?

		self.confirmed_at = Time.current
		self.confirmation_token = ''
		save!
		
	end

	def confirmed?
		confirmed_at.present?
		
	end
	def self.authenticate(email, password)
		confirmed.find_by(email: email).try(:authenticate, password)
	end
	#Essa validação pode ser representada da seguinte forma:
	 #validates_format_of :email, with EMAIL_REGEXP
	#validate do 
	#	errors.add(:email, :invalid) unless email.match(EMAIL_REGEXP)
	#end

end
