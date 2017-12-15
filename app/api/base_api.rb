module BaseAPI
  extend ActiveSupport::Concern

  included do
    prefix "api"
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers
    error_formatter :json, ErrorFormatter
    default_format :json

    rescue_from Grape::Exceptions::ValidationErrors do
      error({error_code: Settings.error_formatter.error_codes.validation_errors, message:
        I18n.t("api_error.validation_errors")}, :bad_request)
    end

    rescue_from APIError::Base do |e|
      error_code = Settings.error_formatter.error_codes.public_send(
        e.class.name.split("::").drop(1).map(&:underscore).first)
      error({error_code: error_code, message: e.message}, e.status)
    end

    rescue_from ActiveRecord::UnknownAttributeError, ActiveRecord::StatementInvalid, JSON::ParserError do |e|
      error({error_code: Settings.error_formatter.error_codes.data_operation, message: e.message},
        :internal_server_error)
    end

    rescue_from ActiveRecord::RecordNotFound do
      error({error_code: Settings.error_formatter.error_codes.record_not_found, message:
        I18n.t("api_error.record_not_found")}, :bad_request)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error({error_code: Settings.error_formatter.error_codes.record_invalid, message: e.message}, :bad_request)
    end

    helpers do
      def authenticate!
        raise APIError::Unauthenticated unless current_user
      end

      def current_user
        @current_user = User.find_by email: params[:email]
      end

      def error message, status = options[:default_status], headers = {}, backtrace = []
        case status
        when Symbol
          error! message, Rack::Utils.status_code(status), headers, backtrace
        when Integer
          error! message, status, headers, backtrace
        else
          raise ArgumentError, I18n.t("api_error.wrong_http_status_code")
        end
      end
    end
  end
end
