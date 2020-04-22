module Mutations
    class DestroyImage < BaseMutation
        argument :id, ID, required: true

        # type Types::ImageType

        def resolve(id:)
            authenticate_user
            Image.find(id).destroy
        end
    end
end