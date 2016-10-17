shared_examples_for 'Votable' do

  describe 'votes_count' do

    it "should return a count of votes" do
      expect(object.votes_count).to eq (0)
    end
  end

  describe 'vote_up' do

    it "should to set votes count to eq 1" do
      object.vote_up(user)
      expect(object.votes).to eq object.votes(rating: 1)
    end
  end

  describe 'vote_down' do

    it "should to set votes count to eq -1" do
      object.vote_down(user)
      expect(object.votes).to eq object.votes(rating: -1)
    end
  end

  describe 'vote_cancel' do

    it "should to set votes count to eq 0" do
      object.vote_cancel(user)
      expect(object.votes).to eq object.votes(rating: 0)
    end
  end
end


shared_examples_for 'Create votes' do

  context 'Not-authenticated user' do

    it 'cannot vote for object' do
      expect { do_request_vote_up }.to_not change(object.votes, :count)
    end
  end

  context "Authenticated user" do
    sign_in_user

    it 'cannot vote for own object' do
      do_request_vote_up
      object.reload
      expect(object.votes).to eq object.votes(rating: 0)
    end

    it 'can set object rating to eq 1' do
      do_request_vote_up
      object.reload
      expect(object.votes).to eq object.votes(rating: 1)
    end

    it 'can set object rating to eq -1' do
      do_request_vote_down
      object.reload
      expect(object.votes).to eq object.votes(rating: -1)
    end
  end
end


shared_examples_for 'Delete votes' do
  
  it 'can cancel own answer vote' do
    do_request_vote_cancel
    object.reload
    expect(object.votes).to eq object.votes(rating: 0)
  end
end
