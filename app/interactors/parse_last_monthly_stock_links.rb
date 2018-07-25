require 'date'

class ParseLastMonthlyStockLinks < RnaAsAPIInteractor
  around do |interactor|
    stdout_info_log 'Parsing monthly stocks...'

    interactor.call

    stdout_info_log "Monthly stocks parsed :
      Last waldec is #{context.link_waldec},
      Last Import is #{context.link_import}"
  end

  def call
    context.links.each do |link|
      if nature_(link) == 'waldec'
        fill_information_link_waldec(link)
      elsif nature_(link) == 'import'
        fill_information_link_import(link)
      else
        stdout_error_log 'Something is wrong with the links. Check that both Waldec and Import are available'
        context.fail!
      end
    end
  end

  private

  def nature_(link)
    file_name = link.split('/').last
    return 'waldec' if file_name.start_with?('rna_waldec')
    return 'import' if file_name.start_with?('rna_import')
  end

  def fill_information_link_waldec(link)
    context.link_waldec = {}
    context.link_waldec['link'] = link.to_s
    context.link_waldec['name'] = link.split('/').last
    context.link_waldec['date'] = get_date(link)
  end

  def fill_information_link_import(link)
    context.link_import = {}
    context.link_import['link'] = link.to_s
    context.link_import['name'] = link.split('/').last
    context.link_import['date'] = get_date(link)
  end

  def check_if_one_waldec_and_one_import
    if context.link_import.nil? || context.link_waldec.nil? # rubocop:disable GuardClause
      stdout_error_log 'Missing link error. Please check link availability.'
      context.fail!
    end
  end

  def get_date(link)
    file_name = link.split('/').last
    date = file_name.match('\d{8}').to_s
    Date.parse(date)
  end
end
