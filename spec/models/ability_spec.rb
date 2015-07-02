require 'rails_helper'
require "cancan/matchers"

RSpec.describe Ability, type: :model do
  describe "#user" do
    subject(:ability){ Ability.new(user) }
    let(:user_with_posts){ create(:user_with_posts) }

    context "with no post" do
    	let(:user){ nil }

			it "expect not have abilities update or destory post" do
				# expect(should not_have_abilities([:update, :destroy], user))
      end
    end
	end
end
