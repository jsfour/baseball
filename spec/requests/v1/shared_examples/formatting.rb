RSpec.shared_examples "a json response" do
  it { expect(subject.content_type).to eq("application/json") }
end

RSpec.shared_examples "a created json response" do
  it { expect(subject.content_type).to eq("application/json") }
  it { expect(subject).to have_http_status(:created) }
end

RSpec.shared_examples "failed json response" do
  it_behaves_like "a json response"
  it { expect(subject).to have_http_status(:error) }
end
