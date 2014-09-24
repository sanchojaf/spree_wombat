module Spree
  module Wombat
    module Handler
      class UpdateCustomerHandler < CustomerHandlerBase

        def process
          email = @payload["customer"]["email"]

          user = Spree.user_class.where(email: email).first
          return response("Can't find customer with email '#{email}'", 500) unless user

          firstname = @payload["customer"]["firstname"]
          lastname = @payload["customer"]["lastname"]

          begin
            if ship_address = Spree::Adreess.find_by_number( @payload["customer"]["shipping_address"].delete('id') )
              user.ship_address = ship_address
            else
              ship_address_attributes = prepare_address(firstname, lastname, @payload["customer"]["shipping_address"])
              user.ship_address = Spree::Address.create!(ship_address_attributes)
            end
            
            if bill_address = Spree::Adreess.find_by_number( @payload["customer"]["billing_address"].delete('id') )
              user.bill_address = bill_address
            else
              bill_address_attributes = prepare_address(firstname, lastname, @payload["customer"]["billing_address"])
              user.bill_address = Spree::Address.create!(bill_address_attributes)
            end  
          rescue Exception => exception
            return response(exception.message, 500)
          end
          
          root_roles = @payload["customer"].delete(:roles)
          process_roles(user, root_roles)
          
          response "Updated customer with #{email} and ID: #{user.id}"
        end

      end
    end
  end
end
