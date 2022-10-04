abstract class AuctionStates{}

class InitState extends AuctionStates{}

class JustEmitState extends AuctionStates{}

class ChangeCategoryLoading extends AuctionStates{}

class ChangeCategorySuccess extends AuctionStates{}

class AuctionLoading extends AuctionStates{}

class AuctionSuccess extends AuctionStates{}

class AuctionWrong extends AuctionStates{}

class AuctionError extends AuctionStates{}

class AuctionUpdated extends AuctionStates{}

class UnsubscribePusher extends AuctionStates{}

class ChangeAuctionHintState extends AuctionStates{}

class SearchState extends AuctionStates{}

class CheckOutAuctionLoading extends AuctionStates{}

class CheckOutAuctionSuccess extends AuctionStates{}

class CheckOutAuctionError extends AuctionStates{}