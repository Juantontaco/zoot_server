class PromoRedemptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    if PromoRedemption.user_already_has_redeemed_an_invite?(current_user)
      return render json: {success: false}
    end

    invite_sender_user = User.find_by_email params[:email]

    @promo_redemption = PromoRedemption.create(
      invited_user: current_user,
      invite_sender_user: invite_sender_user
    )

    render :json => { success: true }
  end
end
