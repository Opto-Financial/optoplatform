# == Schema Information
#
# Table name: spender_profiles
#
#  id              :integer          not null, primary key
#  spender_profile :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
class SpenderProfile < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })

end
