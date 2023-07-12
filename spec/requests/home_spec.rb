require 'rails_helper'

RSpec.describe "root routes", type: :request do
  it "returns route root success" do
    get root_path
    expect(response).to have_http_status(:success)
  end
end
