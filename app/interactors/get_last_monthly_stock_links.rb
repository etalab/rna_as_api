require 'nokogiri'
require 'open-uri'
require 'net/http'

class GetLastMonthlyStockLinks < RnaAsAPIInteractor
  around do |interactor|
    stdout_info_log "Visiting distant repository (#{files_domain})"
    fail_server_unavailable unless available?(files_domain)

    interactor.call

    stdout_success_log "Retrieved last monthly stock links : #{context.links}"

    context.links.each do |link|
      available?(link) ? stdout_success_log("Link #{link} was successfully reached") : fail_link_unavailable(link)
    end
  end

  # Example adress : https://www.data.gouv.fr/fr/datasets/r/cca7b7f6-8a96-4ef8-9e44-54e9173d82f9
  # Parse all links, get first two, it should always be one waldec and one import (random order)
  def call
    last_two_stock_month_link_redirected = available_rna_links.first(2)
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
    doc = Nokogiri::HTML(open(files_repository))
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
