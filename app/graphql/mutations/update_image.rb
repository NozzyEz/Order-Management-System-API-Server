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
            image = Image.find(attributes[:id])

            if image.update(attributes)
                {image: image, errors: []}
            else
                {image: nil, errors: image.errors.full_messages}
            end
        end
    end
end