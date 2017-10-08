class FriendshipsController < ApplicationController
  def create
  		@friendship = current_user.friendships.build(:friend_id => params[:friend_id])
		if @friendship.save
		    flash[:notice] = "Added friend."
		    redirect_to root_url
		  else
		    flash[:error] = "Unable to add friend."
		    redirect_to root_url
		  end

  end
  def accept
  		@friendship = current_user.friendships.find_by(:friend_id => params[:friend_id])
  		if(@friendship)
  			@friendship.update(confirmed: true)
  		end	
  		@inversefriendship = current_user.inverse_friendships.find_by(:user_id => params[:friend_id])
  		if(@inversefriendship)
  			@inversefriendship.update(confirmed: true)
  		end	
  		redirect_to root_url
  end
  def destroy
  	  if params[:type] == "friend"
  	  	@friendship = current_user.friendships.find(params[:id])
  	  else 
  	  	@friendship = current_user.inverse_friendships.find(params[:id])
  	  end
 	  @friendship.destroy
	  flash[:notice] = "Removed friendship."
	  redirect_to root_url
  end
end
