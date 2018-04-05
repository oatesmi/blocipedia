require 'rails_helper'

describe ChargesControllerPolicy do
  subject { ChargesControllerPolicy.new(user, user) }

  context "not logged in" do
    let (:user) { nil }

    it { should forbid_action(:new) }
    it { should forbid_action(:create) }
  end

  context "logged in as standard user" do
    let (:user) { create(:user, role: "standard") }

    it { should permit_action(:new) }
    it { should permit_action(:create) }
  end

  context "logged in as a premium user" do
    let (:user) { create(:user, role: "premium") }

    it { should forbid_action(:new) }
    it { should forbid_action(:create) }

    it { should permit_action(:downgrade) }
  end

  context "logged in as an admin user" do
    let (:user) { create(:user, role: "admin") }

    it { should forbid_action(:new) }
    it { should forbid_action(:create) }
  end
end
