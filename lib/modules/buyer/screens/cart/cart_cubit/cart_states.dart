abstract class CartStates{}

class InitState extends CartStates{}

class JustEmitState extends CartStates {}

class GetCartLoadingState extends CartStates {}

class GetCartSuccessState extends CartStates {}

class GetCartWrongState extends CartStates {}

class GetCartErrorState extends CartStates {}

class GetCheckOutLoadingState extends CartStates {}

class GetCheckOutSuccessState extends CartStates {}

class GetCheckOutWrongState extends CartStates {}

class GetCheckOutErrorState extends CartStates {}

class AddToCartLoadingState extends CartStates {}

class AddToCartWrongState extends CartStates {}

class AddToCartErrorState extends CartStates {}

class RemoveToCartWrongState extends CartStates {}

class RemoveToCartErrorState extends CartStates {}

class CheckCouponLoadingState extends CartStates {}

class CheckCouponSuccessState extends CartStates {}

class CheckCouponWrongState extends CartStates {}

class CheckCouponErrorState extends CartStates {}

class CheckOutLoadingState extends CartStates {}

class CheckOutSuccessState extends CartStates {}

class CheckOutWrongState extends CartStates {}

class CheckOutErrorState extends CartStates {}