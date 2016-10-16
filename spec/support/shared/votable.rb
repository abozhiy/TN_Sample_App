shared_examples_for 'Votable' do
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
