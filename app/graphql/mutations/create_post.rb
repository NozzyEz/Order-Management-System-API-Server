class Mutations::CreatePost < Mutations::BaseMutation
    # arguments
    argument :title,    String,     required: true
    argument :body,     String,     required: true
    argument :user_id,  Integer,    required: true

    # fields
    field :post,    Types::PostType,    null: false
    field :errors,  [String],           null: true
    
    # specifying the type
    # type Types::PostType
    
    # resolve method
    def resolve(title:, body:, user_id:)
        post = Post.new(title: title, body: body, user_id: user_id)

        if post.save
            {
                post: post,
                errors: [],
            }
        else
            {
                post: nil,
                errors: post.errors.full_messages,
            }
        end
    end
end