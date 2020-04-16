module Types
    class ProductInputType < Types::BaseInputObject
        argument :id,                   Integer,    required: true
        argument :name,                 String,     required: false
        argument :organization_id,      Integer,    required: false
        argument :description,          String,     required: false
        argument :inventory,            Integer,    required: false
        argument :images,               String,     required: false
        argument :price,                Float,      required: false

        # type Types::ProductType
    end
    
end
