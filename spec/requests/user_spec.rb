# encoding: UTF-8
require 'rails_helper'

RSpec.describe "User creation", type: :request do
  it "Creates a user" do
    get "/users/new"
    expect(response).to render_template(:new)
    post "/users", user: { name: "user1", token: "tok1" }
    expect(response).to redirect_to("/users")
  end
  it "Creates a twit" do
    User.create!(name: "user1", token: "tok1")
    headers = { "Authorization" => "Token token=tok1" }
    post "/twits", { twit: { message: "message_1" } }, headers
    expect(response).to redirect_to("/twits")
  end
  it "Puts a like" do
    user = User.create!(name: "user1", token: "tok1")
    twit = user.twits.create!(message: "message_1")
    headers = { "Authorization" => "Token token=tok1" }
    patch "/twits/#{twit.id}", {}, headers
    expect(response).to redirect_to("/twits")
  end
end
