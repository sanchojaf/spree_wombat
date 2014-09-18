module Spree
  module Wombat
    module Handler
      class AddCustomerHandler < CustomerHandlerBase

        def process
          email = @payload["customer"]["email"]
          if Spree.user_class.where(email: email).count > 0
            return response "Customer with email '#{email}' already exists!", 500
          end

          user = Spree.user_class.new(email: email)
          user.save(validation: false)

          firstname = @payload["customer"]["firstname"]
          lastname = @payload["customer"]["lastname"]

          begin
            ship_address_attributes = prepare_address(firstname, lastname, @payload["customer"]["shipping_address"])
            user.ship_address = Spree::Address.create!(ship_address_attributes)
            bill_address_attributes = prepare_address(firstname, lastname, @payload["customer"]["billing_address"])
            user.bill_address = Spree::Address.create!(bill_address_attributes)
            
          rescue Exception => exception
            return response(exception.message, 500)
          end

          root_roles = @payload["customer"].delete(:roles)
          process_roles(user, root_roles)
          
          user.save
          response "Added new customer with #{email} and ID: #{user.id}"
        end

      end
    end
  end
end
