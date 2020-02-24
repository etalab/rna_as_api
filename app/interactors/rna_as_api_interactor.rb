class RNAAsAPIInteractor
  include Interactor

  def interactor_log
    @interactor_log ||= Logger.new("#{Rails.root}/log/interactor.log")
  end

  def log_prefix
    '------> '
  end

  def stdout_info_log(msg)
    output = "#{log_prefix} #{msg.capitalize}"
    interactor_log.info(output)
    puts output
  end

  def stdout_success_log(msg)
    output = seven_spaces + "#{check_mark}  #{msg.capitalize}".green
    interactor_log.info(output)
    puts output
  end

  def stdout_warn_log(msg)
    output = seven_spaces + "#{warning_mark} #{msg.capitalize}".yellow
    interactor_log.error(output)
    puts output
  end

  def stdout_error_log(msg)
    output = seven_spaces + "#{error_mark} #{msg.capitalize}".red
    interactor_log.fatal(output)
    puts output
  end

  def seven_spaces
    ' ' * 7
  end

  def warning_mark
    "\xE2\x9A\xA0"
  end

  def check_mark
    "\xE2\x9C\x93"
  end

  def error_mark
    "\xe2\x9c\x96"
  end
end
