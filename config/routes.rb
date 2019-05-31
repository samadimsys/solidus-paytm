# Solidus::Core::Engine.add_routes do
#   post '/paytm', :to => "paytm#index", :as => :paytm_proceed
#   post '/paytm/confirm', :to => "paytm#confirm", :as => :paytm_confirm
#   post '/paytm/cancel', :to => "paytm#cancel", :as => :paytm_cancel
# end

Spree::Core::Engine.routes.draw do
	match '/paytm', :to => "paytm#index", :as => :paytm_proceed, via: [:get, :post]
	match '/paytm/confirm', :to => "paytm#confirm", :as => :paytm_confirm, via: [:get, :post]
	match '/paytm/cancel', :to => "paytm#cancel", :as => :paytm_cancel, via: [:get, :post]
	# get '/paytm', :to => "paytm#index", :as => :paytm_proceed
	# post '/paytm', :to => "paytm#index", :as => :paytm_proceed
	# get '/paytm/confirm', :to => "paytm#confirm", :as => :paytm_confirm
 #  	post '/paytm/confirm', :to => "paytm#confirm", :as => :paytm_confirm
 #  	get '/paytm/cancel', :to => "paytm#cancel", :as => :paytm_cancel
 #  	post '/paytm/cancel', :to => "paytm#cancel", :as => :paytm_cancel
end