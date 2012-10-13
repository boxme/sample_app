module UsersHelper

def gravatar_for(user, options = { :size => 50 }) #size is set 50X50
	gravatar_image_tag(user.email.downcase, :alt => user.name, 
								 :class => 'gravatar',
								 :gravatar => options)
	#:class sets the CSS class of the gravatar
end

end
