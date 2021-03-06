require 'digest'
class User < ActiveRecord::Base
  attr_accessor(:password) #to create a virtual password attribute
  attr_accessible(:email, :name, :password, :password_confirmation)
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true, 
			 :length => { :maximum => 50 }
  
  validates(:email, :presence => true, 
			 :format => { :with => email_regex }, 
			 :uniqueness => { :case_sensitive => false })
  
  #automatically create the virtual attribute 'password_confirmation'
  validates :password, :presence => true,
				:confirmation => true,#to reject those password & password confirmation doesnt match
				:length => { :within => 6..40 }
 
  before_save :encrypt_password #before_save callback
	
	#Return true if the user's password matches the submitted password
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
		#compare encrypted_password with the encrypted version of
		#submitted_password
	end
	 
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil? #password validity
		return user if user.has_password?(submitted_password) #password matching
	end
	
	private #in ruby, all methods defined after private areused internally by the object
	
	def encrypt_password
		self.salt = make_salt if new_record? #returns true if object has not yet been saved to database
		self.encrypted_password = encrypt(password)
		#inside a class, self refers to the object itself, in this case, is user
		#w/o self, a local variable encrypted_password will be created
		#self is not optional when assigning to an attribute
	end
	
	def encrypt(string)
		secure_hash("#{salt}--#{string}")
	end
	
	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")
	end
	
	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end
end

