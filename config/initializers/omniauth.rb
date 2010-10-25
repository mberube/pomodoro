Rails.application.config.middleware.use OmniAuth::Builder do
	provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
	provider :openid, nil
	provider :google_apps, nil
end
