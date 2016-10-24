# handles auction bid and buy actions
class BidManager
  def initialize(user_manager, auction_manager)
    @user_manager = user_manager
    @auction_manager = auction_manager
  end

  def place_bid(user_id, auction_id, amount)
    user = @user_manager.get_user(user_id)
    raise Errors.insufficient_funds if amount > user.account.balance
    auction = @auction_manager.get_auction(auction_id)
    handle_bid_transactions(user, auction, amount)
  end

  def handle_bid_transactions(user, auction, bid_amount)
    current_bid = auction.sale_info.current_bid
    @auction_manager.place_bid(user.id, auction.identifier.id, bid_amount)
    handle_user_finances(current_bid, user, bid_amount)
  end

  def handle_user_finances(previous_bid, bidder, amount)
    bidder.withdraw_money(amount)
    @user_manager.save_user(bidder)
    refund_overthrown_bidder(previous_bid) unless previous_bid == Bid.empty
  end

  def refund_overthrown_bidder(overthrown_bid)
    overthrown_bidder = @user_manager.get_user(overthrown_bid.user_id)
    overthrown_bidder.add_money(overthrown_bid.amount)
    @user_manager.save_user(overthrown_bidder)
  end

  def handle_buyout(user_id, auction_id)
    user = @user_manager.get_user(user_id)
    auction = @auction_manager.get_auction(auction_id)
    if user.account.balance < auction.sale_info.buyout_price
      raise Errors.insufficient_funds
    end
    handle_buyout_transactions(user, auction)
  end

  def handle_buyout_transactions(user, auction)
    auction_sale_info = auction.sale_info
    current_bid = auction_sale_info.current_bid
    @auction_manager.buyout_auction(auction.identifier.id)
    handle_user_finances(current_bid, user, auction_sale_info.buyout_price)
  end

  def close_auction(user_id, auction_id)
    @auction_manager.close_auction(user_id, auction_id)
  end
end
