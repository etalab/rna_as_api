require('./spec/support/custom_json_matchers.rb')

RSpec::Matchers.define :be_not_found_payload do
  match do |response|
    expect(response.body).to look_like_json
    expect(body_as_json).to match(message: 'no results found')
    expect(response).to have_http_status(404)
  end

  failure_message do |response|
    "\"#{response}\" isn't the expected not found payload"
  end

  description do
    'returns a not found payload'
  end
end


RSpec::Matchers.define :find_one_association_with_id_1 do
  match do |response|
    expect(results_no_associations).to match(
      total_results: 1,
      total_pages: 1,
      per_page: 10,
      page: 1
    )
    expect(results_only_associations.first[:id]).to eq(1)
    expect(response).to have_http_status(200)
  end

  failure_message do |response|
    "\"#{response}\" wasn't found correctly"
  end

  description do
    'finds correct hash with 1 association with id 1'
  end
end
