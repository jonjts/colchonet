# encoding: utf-8
class User < ApplicationRecord
	EMAIL_REGEXP = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

	scope :confirmed, -> {where.not(confirmed_at: nil)}

	validates_presence_of :email
	validates_presence_of :full_name
	validates_presence_of :location
	validates_length_of :bio, minimum: 20, allow_blank: false
	validates_uniqueness_of :email

	has_secure_password

	before_create do |user|
		user.confirmation_token = SecureRandom.urlsafe_base64
	end

	def self.authenticate(email, password)
		user = confirmed.find_by(email: email)

		if user.present?
			user.authenticate(password)
		end
	end

	def confirm!
		return if confirmed?
		self.confirmed_at = Time.current
		self.confirmation_token  = ''
		save!
	end

	def confirmed?
		confirmed_at.present?
	end
	
	validate do
		errors.add(:email,:invalid) unless email.match(EMAIL_REGEXP)
	end
end
