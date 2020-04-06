module Types
  class PostType < Types::BaseObject
    field :id,        Integer,            null: false
    field :user_id,   Integer,            null: false
    field :title,     String,             null: false
    field :body,      String,             null: false
    # field user to be queried, specify user and the method used to receive the object   
    field :user,      Types::UserType,    null: false, method: :user

  end
end
