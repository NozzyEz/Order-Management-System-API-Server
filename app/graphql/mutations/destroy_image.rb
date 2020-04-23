module Mutations
    class DestroyImage < BaseMutation
        argument :id, Integer, required: true

        type Types::ImageType

        def resolve(id:)
            authenticate_user
            #! Only allow for admin, or if superuser, allow only to organization's products
            if current_user.role == "admin"
                Image.find(id).destroy
            elsif current_user.role == "superuser" && current_user.organization.image_ids.include?(id)
                Image.find(id).destroy
            else
                raise GraphQL::ExecutionError, "Permission Denied"
            end
        end
    end
end