require 'rails_helper'

RSpec.describe EventPolicy do
  let(:user_event) { create(:user) }
  let(:user2) { create(:user) }
  let(:event) { create(:event, user: user_event) }

  subject { EventPolicy }

  permissions :index? do
    it { is_expected.to permit(user_event) }
    it { is_expected.to permit(nil) }
  end

  permissions :new? do
    it { is_expected.to permit(user_event) }
    it { is_expected.not_to permit(nil) }
  end

  permissions :create? do
    it { is_expected.to permit(user_event) }
    it { is_expected.not_to permit(nil) }
  end

  permissions :show? do
    it { is_expected.to permit(user_event, event) }
    it { is_expected.to permit(user2, event) }
    it { is_expected.to permit(nil, event) }
  end

  permissions :update? do
    it { is_expected.to permit(user_event, event) }
    it { is_expected.not_to permit(user2, event) }
    it { is_expected.not_to permit(nil, event) }
  end

  permissions :edit? do
    it { is_expected.to permit(user_event, event) }
    it { is_expected.not_to permit(user2, event) }
    it { is_expected.not_to permit(nil, event) }
  end

  permissions :destroy? do
    it { is_expected.to permit(user_event, event) }
    it { is_expected.not_to permit(user2, event) }
    it { is_expected.not_to permit(nil, event) }
  end
end
