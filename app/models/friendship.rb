class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'
#Product.where.not(id: params[:id])
  def all_non_eligible_friends(user_id)
  	non_eligible_friends=Friendship.where(user_id: user_id).pluck(:friend_id)
  	non_eligible_inverse_friends=Friendship.where(friend_id: user_id).pluck(:user_id)
  	return non_eligible_friends+non_eligible_inverse_friends  	
  end

  def all_user_requested_friends(user_id)
  	return Friendship.where(confirmed: true,user_id: user_id)
  end

  def all_user_accepted_friends(user_id)
  	return Friendship.where(confirmed: true,friend_id: user_id)
  end
  def all_requests_by_user(user_id)
  	return Friendship.where(confirmed: false,user_id: user_id)
  end
  def all_requests_user(user_id)
	return Friendship.where(confirmed: false,friend_id: user_id)
  end
end
