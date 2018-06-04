require 'test_helper'

class PromoRedemptionTest < ActiveSupport::TestCase
  def create_dummy_user
    User.create(email: 'jkfdljsaf@jklgjdsa.com', password: 'nfkdsfa', password_confirmation: 'nfkdsfa')
  end

  test "cannot_invite_self" do
    user = users(:one)

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user)

    assert_equal ["Cannot invite self"], promo.errors.messages[:invite_sender_user]
    assert_equal true, promo.new_record?
  end

  test "cannot_invite_self not self" do
    user = users(:one)
    user2 = User.create

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user2)

    assert_equal ({}), promo.errors.messages
    assert_equal false, promo.new_record?
  end

  test "redeem_for_user invite_sender_user" do
    user = users(:one)
    user2 = User.create

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user2)

    promo.redeem_for_user(user2)

    assert_nil promo.invited_redeem_time
    assert_equal true, promo.invite_sender_redeem_time.present?
  end

  test "redeem_for_user invited_user" do
    user = users(:one)
    user2 = User.create

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user2)

    promo.redeem_for_user(user)

    assert_nil promo.invite_sender_redeem_time
    assert_equal true, promo.invited_redeem_time.present?
  end

  test "can_redeem_for_user? yes for invited_user, no for invite_sender_user" do
    user = users(:one)
    user2 = User.create

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user2)

    assert_equal true, promo.can_redeem_for_user?(user)
    assert_equal false, promo.can_redeem_for_user?(user2)
  end

  test "can_redeem_for_user? yes for invited_user, yes for invite_sender_user, bc of ride for invited_user" do
    user = users(:one)
    user2 = User.create

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user2)

    user.rides << Ride.create(payment_source: 'nfkdsa')

    assert_equal true, promo.can_redeem_for_user?(user)
    assert_equal true, promo.can_redeem_for_user?(user2)
  end

  test "can_redeem_for_user? no for invited_user bc of already redeemed, yes for invite_sender_user, bc of ride for invited_user" do
    user = users(:one)
    user2 = User.create

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user2)

    user.rides << Ride.create(payment_source: 'nfkdsa')

    promo.redeem_for_user(user)

    assert_equal false, promo.can_redeem_for_user?(user)
    assert_equal true, promo.can_redeem_for_user?(user2)
  end

  test "can_redeem_for_user? yes for invited_user, no for invite_sender_user, not bc of ride for invited_user, but bc of already redeemed" do
    user = users(:one)
    user2 = User.create

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user2)

    user.rides << Ride.create(payment_source: 'nfkdsa')

    promo.redeem_for_user(user2)

    assert_equal true, promo.can_redeem_for_user?(user)
    assert_equal false, promo.can_redeem_for_user?(user2)
  end

  test "find_redeemables_for_user?" do
    user = users(:one)
    user2 = create_dummy_user

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user2)

    user.rides << Ride.create(payment_source: 'nfkdsa')

    assert_equal [promo], PromoRedemption.find_redeemables_for_user(user)
    assert_equal [promo], PromoRedemption.find_redeemables_for_user(user2)
  end

  test "user_has_redemption? yes for invited_user, yes for invite_sender_user, not bc of ride for invited_user" do
    user = users(:one)
    user2 = create_dummy_user

    promo = PromoRedemption.create(invited_user: user, invite_sender_user: user2)

    user.rides << Ride.create(payment_source: 'nfkdsa')

    assert_equal true, PromoRedemption.user_has_redemption?(user)
    assert_equal true, PromoRedemption.user_has_redemption?(user2)
  end
end
