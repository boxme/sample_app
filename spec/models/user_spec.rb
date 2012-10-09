require 'spec_helper'

describe User do
	
	before(:each) do #runs the codes inside the block before each example
		@attr = { :name => "Example User", :email => "user@example.com" }
	end
	
	it "should create a new instance given value attributes" do
		User.create!(@attr) #create! raises an exception if creation fails
	end
	
	#test the presence of a name
	it "should require a name"  do
		no_name_user = User.new(@attr.merge(:name => ""))
		no_name_user.should_not be_valid
		#the line above is the same as no_name_user.valid?.should_not == true
		#the line above should return false to pass the test
	end
	
	#test the presence of an email
	it "should require an email address" do
		no_email_user = User.new(@attr.merge(:email  => ""))
		no_email_user.should_not be_valid
	end
	
	#test the length of a name
	it "should reject names that are too long" do
		long_name = "a" * 51
		long_name_user = User.new(@attr.merge(:name => long_name))
		long_name_user.should_not be_valid
	end
	
	it "should accept valid email addresses" do
		addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
		addresses.each do |address|
			valid_email_user = User.new(@attr.merge(:email => address))
			valid_email_user.should be_valid
		end
	end
	
	it "should reject invalid email addresses" do
		addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
		addresses.each do |address|
			invalid_email_user = User.new(@attr.merge(:email => address))
			invalid_email_user.should_not be_valid
		end
	end
	
	#test for the rejection of duplicate email addresses
	it "should reject duplicate email addresses" do
		User.create!(@attr) #Put a user with a given email address into the database
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	
	#test for rejection of duplicate email, insensitive to case
	it "should reject email addresses identical up to case" do
		upcased_email = @attr[:email].upcase
		User.create!(@attr.merge(:email => upcased_email))
		user_with_duplicate_email = User.new(@attr)
		user_with_duplicate_email.should_not be_valid
	end
	
end
