class V1::Users < Grape::API
  after_validation{authenticate!}

  resources :users do
    params do
      requires :email, type: String, regexp: Settings.validations.email_regex, allow_blank: false
    end
    post do
      
    end
  end
end
