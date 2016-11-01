require 'spec_helper'

describe AskAwesomely::ApiClient, 'interface to Typeform I/O' do
  subject { AskAwesomely::ApiClient.new }

  describe 'successful API connection and authentication' do
    it 'can retrieve the information about Typeform I/O' do
      VCR.use_cassette('get_api_info') do
        info = subject.get_info
        info.delete('time')

        info.must_equal('name' => 'Typeform I/O Build API',
                        'description' => 'Build API for creating forms awesomely',
                        'version' => 'v0.4',
                        'documentation' => 'https://docs.typeform.io/',
                        'support' => 'support@typeform.io')
      end
    end
  end

  describe 'saving a typeform' do
    it 'updates the Typeform with the new ID and public/private URLs' do
      VCR.use_cassette('submit_basic_typeform') do
        typeform = BasicTypeform.build

        typeform.id.must_equal('uc5ag9dzpW')
        typeform.title.must_equal('My Example Form')
        typeform.public_url.must_equal('https://forms.typeform.io/to/uc5ag9dzpW')
        typeform.private_url.must_equal('https://api.typeform.io/v0.4/forms/uc5ag9dzpW')
        typeform.fields.must_equal(267_430 => 'This is a test!', 267_431 => 'What do you think?')
      end
    end
  end
end
