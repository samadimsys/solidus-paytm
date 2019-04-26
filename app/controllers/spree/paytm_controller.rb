module Spree
  class PaytmController < StoreController
    protect_from_forgery only: :index

    def index
      payment_method = Spree::PaymentMethod.find(params[:payment_method_id])
      order = current_order
      @param_list = Hash.new
      @param_list['MID'] = payment_method.preferred_merchant_id
      @param_list['INDUSTRY_TYPE_ID'] = payment_method.preferred_industry_type_id
      @param_list['CHANNEL_ID'] = payment_method.preferred_channel_id
      @param_list['WEBSITE'] = payment_method.preferred_website
      if @param_list.values.select{ |value| value unless value.present? }.present?
        flash[:error] = Spree.t('paytm.paytm_payment_failed')
        redirect_to checkout_state_path(order.state) and return
      else
        @param_list['REQUEST_TYPE'] = payment_method.request_type
        @param_list['ORDER_ID'] = payment_method.txnid(order)
        @param_list['TXN_AMOUNT'] = order.total.to_s
        if(address = current_order.bill_address || current_order.ship_address)
          phone = address.phone
        end
        #if user is not loggedin, Passing phone as customer id
        cust_id = spree_current_user.nil? ? phone : spree_current_user.id
        @param_list['CUST_ID'] = "CUST-#{cust_id}-ORDER-#{payment_method.txnid(order)}"
        @param_list['MOBILE_NO'] = phone
        @param_list['EMAIL'] = order.email

        # @param_list["CALLBACK_URL"] = "http://7dd08f4e.ngrok.io/paytm/confirm";
        @param_list["CALLBACK_URL"] = @param_list['WEBSITE'].to_s + "/paytm/confirm".to_s;

        checksum = payment_method.new_pg_checksum(@param_list, payment_method.preferred_merchant_key)
        @param_list['CHECKSUMHASH'] = checksum
        @paytm_txn_url = payment_method.txn_url
      end
    end

    def confirm
      payment_method = Spree::PaymentMethod.find_by(type: Spree::Gateway::Paytm)
      checksum_hash = params["CHECKSUMHASH"]
      params.delete("CHECKSUMHASH")
      @status = params["STATUS"]
      @orderid = params["ORDERID"]
      @order = current_order || Spree::Order.find_by(number: @orderid.split("-").last)
      @payment = @order.payments.create!(
        source: Spree::PaytmCheckout.create(
          checksum: checksum_hash,
          order_id: @orderid,
          txn_id: params['TXNID']
        ),
        payment_method: payment_method,
        amount: @order.total,
        response_code: params['RESPCODE']
      )
      if @status == "TXN_SUCCESS"
        @payment.complete!
        advance_and_complete(@payment.order)
        # @order.next
        @message = Spree.t(:order_processed_successfully)
        @current_order = nil
        flash.notice = Spree.t(:order_processed_successfully)
        flash['order_completed'] = true
        @error = false
        redirect_to redirect_path(@payment.try(:order))
        # @redirect_path = order_path(@order)
      else
        @payment.state = "failed"
        @payment.save
        @order.update_attributes(payment_state: "failed")
        @error = true
        @message = "There was an error processing your payment"
        redirect_to redirect_path(@payment.try(:order))
        # @redirect_path = checkout_state_path(@order.state)
      end
    end

    def advance_and_complete(order)
      order.next!
      order.complete! if order.can_complete?
    end

    def redirect_path(order)
      return cart_path unless order
      order.complete? ? order_path(order) : checkout_state_path(order.state)
    end

  end
end
