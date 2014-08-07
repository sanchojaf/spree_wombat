require 'active_model/serializer'
 
module Spree
  module Wombat
    class SourceSerializer < ActiveModel::Serializer
      attributes :name, :month, :year, :cc_type, :last_digits, :gateway_payment_profile_id, :gateway_customer_profile_id
 
      def gateway_customer_profile_id
        object.gateway_customer_profile_id
      end
 
      def month
        object.month
      end
      
      def year
        object.year
      end

      def gateway_payment_profile_id
        object.gateway_payment_profile_id
      end
 
      def name
        object.name
      end
 
      def cc_type
        object.cc_type
      end
 
      def last_digits
        object.last_digits
      end
    end
  end
end
