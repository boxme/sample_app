require 'spec_helper'

describe UsersController do
	render_views #necessary for the title tests to work#
	
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should hvae the right title" do
	    get 'new'
	    response.should have_selector("title", :content => "Sign up")
    end
    
  end

end
