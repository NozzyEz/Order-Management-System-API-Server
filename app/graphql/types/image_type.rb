module Types
    class ImageType < Types::BaseObject
        field :id,          ID, null: false
        field :product_id,  ID, null: false
        field :is_thumb,    Boolean, null: false
        field :url,         String, null: false
    end
end