module Types
    class UserInputType < BaseInputObject
        argument :username,                 String,     required: true
        argument :email,                    String,     required: true
        argument :first_name,               String,     required: true
        argument :last_name,                String,     required: true
        argument :password,                 String,     required: true
        argument :password_confirmation,    String,     required: true
        argument :organization_id,          Integer,    required: true
    end
end