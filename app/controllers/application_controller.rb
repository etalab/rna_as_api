class ApplicationController < ActionController::API
  def default_10_max_100(param_per_page)
    per_page = param_per_page || 10
    per_page.to_i < 100 ? per_page.to_i : 100
  end
end
