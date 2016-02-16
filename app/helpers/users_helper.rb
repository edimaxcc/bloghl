module UsersHelper

#Return the gravatar for the user
def gravatar(user)
gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
gravatar_url = "https://secure.gravatar.com/gravatar/#{gravatar_id}"
image_tag(gravatar_url, alt: user.name, class: "gravatar")
end




end
