class Mutations::UpdatePost < Mutations::BaseMutation
    # Arguments
    argument :id,       Integer,    required: true
    argument :title,    String,     required: false
    argument :body,     String,     required: false
    argument :user_id,  Integer,    required: false
    
    # Fields
    field :post,    Types::PostType,    null: true
    field :errors,  [String],           null: true

    # resolve method
    def resolve(**attributes)
        post = Post.find(attributes[:id])
        
        if post.update(attributes)
            {post: post, errors: []}
        else
            {post: nil, errors: post.errors.full_messages}
        end
    end
end