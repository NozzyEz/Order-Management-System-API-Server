module Mutations
    class CreateImage < Mutations::BaseMutation
        argument :product_id,   ID,      required: true
        argument :is_thumb,     Boolean, required: true
        argument :url,          String,  required: true

        field :image,  Types::ImageType, null: true
        field :errors, [String],         null: true

        def resolve(**attributes)
            authenticate_user
            if current_user.admin? || current_user.superuser?
                image = Image.new(attributes)

                if image.save
                    {image: image, errors: []}
                else
                    raise GraphQL::ExecutionError, image.errors.full_messages.join(", ")
                end
            else
                raise GraphQL::ExecutionError, "Permission Denied"
            end
        end
    end
end