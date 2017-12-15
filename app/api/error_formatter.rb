module ErrorFormatter
  def self.call message, _backtrace, _options, _env
    case message
    when Hash
      code = message[Settings.error_formatter.error_code_key.to_sym]
      msg = message[Settings.error_formatter.message_key.to_sym]
    else
      code = Settings.error_formatter.error_codes.unexpected_exception
      msg = message
    end
    {
      Settings.error_formatter.error_code_key => code,
      Settings.error_formatter.message_key => msg
    }.to_json
  end
end
