shared_examples_for 'Delete attachment' do
  
  context 'Author of question' do
    sign_in_user
  
    it "deletes attachment" do
      expect { delete :destroy, id: object_attachment, format: :js }.to change(Attachment, :count).by(-1)
    end

    it "render destroy template" do
      delete :destroy, id: object_attachment, format: :js
      expect(response).to render_template :destroy
    end
  end

  context 'Other user' do

    it 'cannot delete attachment' do
      expect { delete :destroy, id: object_attachment, format: :js }.to_not change(Attachment, :count)
    end
  end
end