class APIError::InvalidRecaptchaToken < APIError::Base
  def initialize *args
    super status: :bad_request, message: args[0]
  end
end
