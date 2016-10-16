shared_examples_for 'API Authenticable' do
  context 'unauthorized' do
    it 'returns 401 status if no access_token' do
      do_request
      expect(response.status).to eq 401
    end

    it 'returns 401 status if no access_token' do
      do_request(access_token: '1234')
      expect(response.status).to eq 401
    end
  end
end

shared_examples_for 'API success authorized' do
  it 'returns 200 status code' do
    expect(response).to be_success
  end
end

shared_examples_for 'API returns list of subject' do
  it 'returns list' do
    expect(response.body).to have_json_size(2)
  end
end

shared_examples_for 'API request does not contain password' do
  %w(password encrypted_password).each do |attr|
    it "does not contain #{attr}" do
      expect(response.body).to_not have_json_path(attr)
    end
  end
end
