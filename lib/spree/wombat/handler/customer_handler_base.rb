module Spree
  module Wombat
    module Handler
      class CustomerHandlerBase < Base

        def prepare_address(firstname, lastname, address_attributes)
          
          address_attributes['country'] = {
            'iso' => address_attributes['country'].upcase }

          if address_attributes['state'].length == 2
            address_attributes['state'] = {
              'abbr' => address_hash['state'].upcase }
          else
            address_attributes['state'] = {
              'name' => address_attributes['state'].capitalize }
          end

          country_iso = address_attributes.delete(:country)
          country = Spree::Country.find_by_iso(country_iso)
          raise Exception.new("Can't find a country with iso name #{country_iso}!") unless country_iso
          address_attributes[:country_id] = country.id

          state_name = address_attributes.delete(:state)
          if state_name
            state = Spree::State.find_by_name(state_name)
            raise Exception.new("Can't find a State with name #{state_name}!") unless state
            address_attributes[:state_id] = state.id
          end

          address_attributes[:firstname] = firstname
          address_attributes[:lastname] = lastname

          address_attributes
        end
        

        def process_roles(user, roles)
          return unless roles.present?

          roles.each do |role_name|
            role = Spree::Role.where(name: role_name).first_or_initialize do |role|
              role.name = role_name
              role.save!
            end
            user.roles << role unless user.roles.include?(role)
          end
        end

      end
    end
  end
end
