require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  # Validations
  it { is_expected.to be_valid }
end
