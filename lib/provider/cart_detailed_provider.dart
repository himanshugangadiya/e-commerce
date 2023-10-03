import 'package:flutter/cupertino.dart';

class CartDetailedProvider extends ChangeNotifier {
  int cart = 1;
  num totalPrice = 0;

  addCart() {
    cart++;
    notifyListeners();
  }

  subCart() {
    if (cart > 1) {
      cart--;
      notifyListeners();
    }
  }

  discount(price, discount) {
    return ((price * cart) * discount) / 100;
  }

  priceIntoCart(price, cart) {
    return (price * cart);
  }

  tax(price, cart, tax) {
    return ((price * cart) * tax) / 100;
  }

  total(price, tax, discount, cart, shippingCost) {
    num totalPrice = (price * cart);
    num totalDiscount = ((price * cart) * discount) / 100;
    num totalAfterDiscount = totalPrice - totalDiscount;
    num totalTax = (totalPrice * tax) / 100;

    this.totalPrice = (totalAfterDiscount + totalTax + shippingCost);
    return (totalAfterDiscount + totalTax + shippingCost);
  }

  clearData() {
    cart = 1;
    totalPrice = 0;
    notifyListeners();
  }
}
