import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_workspace/devstory_intermediate/house_of_tomorrow_mvvm/src/model/cart_item.dart';
import 'package:flutter_workspace/devstory_intermediate/house_of_tomorrow_mvvm/src/service/cart_service.dart';

import '../../dummy.dart';

void main() {
  late CartService cartService;

  setUp(() {
    cartService = CartService();
  });

  group('CartService', () {
    group('add()', () {
      test('신규 CartItem을 cartItemList에 추가한다.', () {
        cartService.add(Dummy.cartItem);
        expect(cartService.cartItemList.length, 1);
      });
    });

    group('selectedCartItemList', () {
      test('isSelected가 true인 CartItem만 반환한다.', () {
        cartService.add(Dummy.cartItem.copyWith(isSelected: true));
        cartService.add(Dummy.cartItem.copyWith(isSelected: true));
        cartService.add(Dummy.cartItem.copyWith(isSelected: false));
        expect(cartService.selectedCartItemList.length, 2);
        for (final cartItem in cartService.selectedCartItemList) {
          expect(cartItem.isSelected, true);
        }
      });
    });

    group('update()', () {
      test('선택한 index의 CartItem을 수정한다.', () {
        cartService.add(Dummy.cartItem);
        CartItem newCartItem = Dummy.cartItem.copyWith(
          count: 100,
        );
        cartService.update(0, newCartItem);
        expect(cartService.cartItemList[0], newCartItem);
      });
    });

    group('delete()', () {
      test('deleteList에 포함된 cartItemList의 CartItem을 삭제한다.', () {
        cartService.add(Dummy.cartItem.copyWith(isSelected: true));
        cartService.add(Dummy.cartItem.copyWith(isSelected: true));
        cartService.add(Dummy.cartItem.copyWith(isSelected: false));
        cartService.add(Dummy.cartItem.copyWith(isSelected: false));
        cartService.delete(cartService.selectedCartItemList);
        expect(cartService.cartItemList.length, 2);
        for (final cartItem in cartService.cartItemList) {
          expect(cartItem.isSelected, false);
        }
      });
    });
  });
}
