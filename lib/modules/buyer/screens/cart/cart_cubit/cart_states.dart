abstract class CartStates{}

class InitState extends CartStates{}

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