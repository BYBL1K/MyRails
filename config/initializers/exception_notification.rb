if Rails.env == "production" || Rails.env == "staging" # || Rails.env == "development"

	exceptions = []
	exceptions << 'ActiveRecord::RecordNotFound'
	exceptions << 'AbstractController::ActionNotFound'
	exceptions << 'ActionController::RoutingError'
	exceptions << 'ActionController::InvalidAuthenticityToken'

	server_name = case Rails.env
		when "production" 	then "mystore.com"
		when "staging"		then "staging.mystore.com"
		when "development"	then "DEVELOPMENT mystore"
		else
			"uknown env mystore"
	end
	
	MyStore::Application.config.middleware.use ExceptionNotification::Rack,
  email: {
    deliver_with: :deliver, # Rails >= 4.2.1 do not need this option since it defaults to :deliver_now
    email_prefix: "[#{server_name} error] ",
    sender_address: "errors@mystore.com",
    exception_recipients: ["chekalin-kanztorg@yandex.ru"]
  },
  ignore_exceptions: exceptions

end			