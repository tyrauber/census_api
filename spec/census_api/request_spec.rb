require 'spec_helper'

describe CensusApi::Request, :vcr do

  let(:api_key) { ENV['API_KEY'] || "ABCD" }

  context '#find' do
    [{source: 'sf1', field: 'P001001', results: [
        {'P001001'=>'37253956', 'name'=>'California', 'state'=>'06'},
        {'P001001'=>'1510271', 'name'=>'Alameda County, California', 'state'=>'06', 'county'=>'001'}
      ]},
      {source: 'acs5', field: 'B00001_001E', results: [
        {'B00001_001E'=>'2330290', 'name'=>'California', 'state'=>'06'},
        {'B00001_001E'=>'92854', 'name'=>'Alameda County, California', 'state'=>'06', 'county'=>'001'}
      ]}
    ].each do |test|

      describe "#{test[:source]} for a geography type" do

        let(:params) do
          {
            key: api_key,
            source: test[:source],
            vintage: 2010,
            fields: test[:field],
            level: 'STATE',
            within: []
          }
        end

        before(:each) do
          @collection = CensusApi::Request.find(test[:source], params)
        end

        it 'should have 52 results' do
          expect(@collection.count).to eq(52)
        end

        it 'should include fields for each result' do
          @collection.each do |result|
            expect(result).to include(test[:field])
            expect(result).to include('name')
            expect(result).to include('state')
          end
        end
      end

      describe "#{test[:source]} for a geography type and id" do
        let(:params) do
          {
            key: api_key,
            source: test[:source],
            vintage: 2010,
            fields: test[:field],
            level: 'STATE:06',
            within: []
          }
        end

        before(:each) do
          @collection = CensusApi::Request.find(test[:source], params)
        end

        it 'should have one result' do
          expect(@collection.count).to eq(1)
        end

        it 'should include fields for each result' do
          @collection.each do |result|
            expect(result).to eq(test[:results][0])
          end
        end
      end

      describe "#{test[:source]} for a geography type" do

        let(:params) do
          {
            key: api_key,
            source: test[:source],
            vintage: 2010,
            fields: test[:field],
            level: 'COUNTY',
            within: ['STATE:06']
          }
        end

        before(:each) do
          @collection = CensusApi::Request.find(test[:source], params)
        end

        it 'should have one result' do
          expect(@collection.count).to eq(58)
        end

        it 'should include fields for each result' do
          @collection.each do |result|
            expect(result).to include(test[:field])
            expect(result).to include('name')
            expect(result).to include('state')
          end
        end
      end

      describe "#{test[:source]} for a geography" do

        let(:params) do
          {
            key: api_key,
            source: test[:source],
            vintage: 2010,
            fields: test[:field],
            level: 'COUNTY:001',
            within: ['STATE:06']
          }
        end

        before(:each) do
          @collection = CensusApi::Request.find(test[:source], params)
        end

        it 'should have one result' do
          expect(@collection.count).to eq(1)
        end

        it 'should include fields for each result' do
          @collection.each do |result|
            expect(result).to eq(test[:results][1])
          end
        end
      end
    end
  end

  context 'DATASETS' do
    CensusApi::Client::DATASETS.each do |source|
      describe "#{source}" do
        let(:params) do
          {
            key: api_key,
            source: source,
            vintage: source.match('sf1') ? 2010 : 2012,
            fields: source.match('sf1') ? 'P001001' : 'B00001_001E',
            level: 'STATE',
            within: []
          }
        end

        it "#{source} should be valid" do
          @collection = CensusApi::Request.find(source, params)
          expect(@collection.count).to eq(52)
        end
      end
    end
  end

  context '.vintage' do
    describe 'vintage' do

      let(:params) do
        {
          key: api_key,
          source: 'acs5',
          vintage: 2010,
          fields: 'B00001_001E',
          level: 'STATE',
          within: []
        }
      end

      before(:each) do
        @collection_2010 = CensusApi::Request.find(params[:source], params)
        params.merge!(vintage: 2012)
        @collection_2012 = CensusApi::Request.find(params[:source], params)
      end

      it 'should be valid' do
        expect(@collection_2010.count).to eq(52)
      end

      it 'should not be same result set' do
        expect(@collection_2010).not_to eq(@collection_2012)
      end
    end
  end

  context '#format' do
    it 'should add wildcard after reformatting geography type without id' do
      expect(CensusApi::Request.format('COUSUB')).to eq('county%20subdivision:*')
    end
  end
end
