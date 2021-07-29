# frozen_string_literal: true

RSpec.describe Worksnaps::User do
  describe ".find_by_id" do
    let(:id) { 8514 }
    subject { described_class.find_by_user_id(id) }

    it "returns the email" do
      expect(subject.id).to eq(id)
    end
  end
end
