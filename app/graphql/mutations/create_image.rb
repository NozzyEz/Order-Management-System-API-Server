module Mutations
    class CreateImage < Mutations::BaseMutation
        argument :product_id,   ID,      required: true
        argument :is_thumb,     Boolean, required: true
        argument :url,          String,  required: true

        field :image,  Types::ImageType, null: false
        field :errors, [String],         null: true

        def resolve(**attributes)
            authenticate_user
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
        end
    end
end