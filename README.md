# solidus_paytm
Paytm payment gateway integration for solidus

## Installation

1. Add this extension to your Gemfile with this line:

        gem 'solidus_paytm', :github => 'samadimsys/solidus_paytm'

2. Install the gem using Bundler:

        bundle install

3. Add migrations from extension:

        rails g solidus_paytm:install

4. Restart your server

5. Add new payment method with provider

        Solidus::Gateway::Paytm

6. Set all credentials from your paytm sandbox account. If you don't have it you can use from [Paytm Discussion Forum](http://paywithpaytm.com/developer/discussion/topic/sandbox-test-credentials-for-testing-paytm-solutions/)

7. Set CALLBACK_URL to http://HOSTNAME/paytm/confirm in you sandbox web application. In case you are using test credentials from above link you can set CALLBACK_URL by overriding index method of app/controller/spree/paytm_controller.rb

        @param_list['CALLBACK_URL'] = 'http://HOSTNAME/paytm/confirm'
