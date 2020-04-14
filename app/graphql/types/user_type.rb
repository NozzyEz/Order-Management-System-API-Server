module Types
  class UserType < Types::BaseObject
    field :id,          ID,                 null: false
    field :username,    String,             null: true
    field :org_id,      Integer,            null: true
    field :first_name,  String,             null: true
    field :last_name,   String,             null: true
    field :email,       String,             null: true
    field :posts,       [Types::PostType],  null: true
    field :posts_count, Integer,            null: true

    def posts_count
      object.posts.size
    end
    
  end
end
