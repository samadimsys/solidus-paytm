# Solidus::Core::Engine.add_routes do
#   post '/paytm', :to => "paytm#index", :as => :paytm_proceed
#   post '/paytm/confirm', :to => "paytm#confirm", :as => :paytm_confirm
#   post '/paytm/cancel', :to => "paytm#cancel", :as => :paytm_cancel
# end

Spree::Core::Engine.routes.draw do
	get '/paytm', :to => "paytm#index", :as => :paytm_proceed
	# post '/paytm', :to => "paytm#index", :as => :paytm_proceed
  	post '/paytm/confirm', :to => "paytm#confirm", :as => :paytm_confirm
  	post '/paytm/cancel', :to => "paytm#cancel", :as => :paytm_cancel
end