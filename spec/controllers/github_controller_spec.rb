require 'spec_helper'

describe GithubController do

  it "must respond to statusboard.json" do
    get :statusboard
    expect(response).to be_success
  end

end
