require 'spec_helper'

describe 'CensusApi::Examples', :vcr do

  let(:api_key) { ENV['API_KEY'] || "ABCD" }
  let(:client) { CensusApi::Client.new(api_key, {dataset: 'sf1', vintage: 2010} ) }

  describe 'sf1' do
    describe '#where' do
      Census2010DecSf1::EXAMPLES.each do |query|
        it "should retrieve #{query.join(",")}" do
          response = client.send(:where, {fields: query[0], level: query[1], within: query[2]})
          expect{ response }.not_to raise_error
          expect(response).to be_a(Array)
          expect(response.first).to include('name')
        end
      end
    end
  end
end