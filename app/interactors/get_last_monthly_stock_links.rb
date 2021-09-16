require 'nokogiri'
require 'open-uri'
require 'net/http'

class GetLastMonthlyStockLinks < RNAAsAPIInteractor
  around do |interactor|
    stdout_info_log "Visiting distant repository (#{files_domain})"
    fail_server_unavailable unless available?(files_domain)

    interactor.call

    stdout_success_log "Retrieved last monthly stock links : #{context.links}"

    context.links.each do |link|
      available?(link) ? stdout_success_log("Link #{link} was successfully reached") : fail_link_unavailable(link)
    end
  end

  def call
    last_two_stock_month_link_redirected = available_rna_links.first(4).uniq
    last_two_stock_month_link = get_redirection(last_two_stock_month_link_redirected)
    context.links = last_two_stock_month_link
  end

  private

  def fail_server_unavailable
    stdout_error_log "Error : distant directory #{files_domain} is unreachable."
    context.fail!
  end

  def fail_link_unavailable(link)
    stdout_error_log "Error : #{link} could not be reached."
    context.fail!
  end

  def available?(link)
    uri = URI.parse(link)
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      header = http.request_head uri
      header.is_a? Net::HTTPSuccess
    end
  end

  def available_rna_links
    doc = Nokogiri::HTML files_uri.open
    links_nodes = doc.css('a')
    links = links_nodes.map { |e| e['href'] }.compact
    links.select { |e| e.start_with?(link_filename_pattern) }
  end

  def get_redirection(links)
    links.map do |link|
      uri = URI.parse(link)
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        response = http.request_get uri
        response['location']
      end
    end
  end

  def files_uri
    URI.parse files_repository
  end

  def files_domain
    'https://www.data.gouv.fr/fr/'
  end

  def files_repository
    "#{files_domain}datasets/repertoire-national-des-associations/"
  end

  def link_filename_pattern
    "#{files_domain}datasets/r/"
  end
end
