require 'active_model/serializer'
 
module Spree
  module Wombat
    class SourceSerializer < ActiveModel::Serializer
      attributes :name, :cc_type, :last_digits, :source_type, :month, :year, :gateway_payment_profile_id, :gateway_customer_profile_id
 
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
        object.try(:name) || "N/A"
      end
 
      def cc_type
        object.try(:cc_type) || "N/A"
      end
 
      def last_digits
        object.try(:last_digits) || "N/A"
      end

      def source_type
        object.class.to_s
      end
    end
  end
end
