require 'active_model/serializer'

module Spree
  module Wombat
    class RoleSerializer < ActiveModel::Serializer

      attributes :id, :name

      def name
        object.name
      end

    end
  end
end
