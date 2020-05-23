module Mutations
    class UpdateImage < BaseMutation
        argument :id,           ID,         required: true
        argument :product_id,   ID,         required: false
        argument :is_thumb,     Boolean,    required: false
        argument :url,          String,     required: false

        field :image,    Types::ImageType,   null: false
        field :errors,   [String],           null: true

        def resolve(**attributes)
            authenticate_user
            if current_user.admin? || current_user.superuser?
                image = Image.find(attributes[:id])

                if image.update(attributes)
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