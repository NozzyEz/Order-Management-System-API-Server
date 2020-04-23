module Mutations
    class CreateImage < Mutations::BaseMutation
        argument :product_id,   ID,      required: true
        argument :is_thumb,     Boolean, required: true
        argument :url,          String,  required: true

        field :image,  Types::ImageType, null: false
        field :errors, [String],         null: true

        def resolve(**attributes)
            authenticate_user
            if current_user.role == "admin" || current_user.role == "superuser"
                image = Image.new(attributes)

                if image.save
                    {
                        image: image,
                        errors: []
                    }
                else
                    {
                        image: nil,
                        errors: image.errors.full_messages
                    }
                end
            else
                raise GraphQL::ExecutionError, "Permission Denied"
            end
        end
    end
end