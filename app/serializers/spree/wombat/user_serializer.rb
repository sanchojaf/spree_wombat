require 'active_model/serializer'

module Spree
  module Wombat
    # Accepts a Spree::StockItem and serializes this to the Hub Inventory format
    class UserSerializer < ActiveModel::Serializer

      attributes :id, :email, :firstname, :lastname
      has_one :shipping_address, serializer: Spree::Wombat::AddressSerializer
      has_one :billing_address, serializer: Spree::Wombat::AddressSerializer
      has_many :spree_roles, serializer: Spree::Wombat::RoleSerializer  
      
      def id
        object.email
      end

      def email
        object.email
      end

      def firstname
        object.first_name if object.first_name.present?
      end

      def lastname
        object.last_name if object.last_name.present?
      end

    end
  end
end
