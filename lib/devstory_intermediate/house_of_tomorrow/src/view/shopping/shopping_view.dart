import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../theme/component/bottom_sheet/setting_bottom_sheet.dart';
import '../../../theme/component/button/button.dart';
import '../../../theme/component/cart_button.dart';
import '../../../theme/component/input_field.dart';
import '../../../util/helper/network_helper.dart';
import '../../../util/lang/generated/l10n.dart';
import '../../model/product.dart';
import 'widget/product_card_grid.dart';
import 'widget/product_empty.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  // List<Product> productList = [];
  List<Product> productList = [];
  final TextEditingController textController = TextEditingController();

  String get keyword => textController.text.trim();

  Future<void> searchProductList() async {
    try {
      final res = await NetworkHelper.dio.get(
        'https://gist.githubusercontent.com/nero-angela/d16a5078c7959bf5abf6a9e0f8c2851a/raw/04fb4d21ddd1ba06f0349a890f5e5347d94d677e/ikeaSofaDataIBB.json',
      );

      setState(() {
        productList = jsonDecode(res.data).map<Product>((json) {
          return Product.fromJson(json);
        }).where((product) {
          /// 키워드가 비어있는 경우 모두 반환
          if (keyword.isEmpty) return true;

          /// name이나 brand에 키워드 포함 여부 확인
          return "${product.name}${product.brand}"
              .toLowerCase()
              .contains(keyword.toLowerCase());
        }).toList();
      });
    } catch (e, s) {
      log('Failed to searchProductList', error: e, stackTrace: s);
    }
  }

  @override
  void initState() {
    super.initState();
    searchProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.shopping),
        actions: [
          // 설정 버튼
          Button(
            icon: 'option',
            type: ButtonType.flat,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const SettingBottomSheet();
                },
              );
            },
          ),

          // 카트 버튼
          const CartButton(),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                // 검색
                Expanded(
                  child: InputField(
                    controller: textController,
                    onClear: searchProductList,
                    onSubmitted: (text) => searchProductList(),
                    hint: S.current.searchProduct,
                  ),
                ),
                const SizedBox(width: 16),

                // 검색 버튼
                Button(
                  icon: 'search',
                  onPressed: searchProductList,
                ),
              ],
            ),
          ),

          // ProductCardList
          Expanded(
            child: productList.isEmpty
                ? const ProductEmpty()
                : ProductCardGrid(productList),
          ),
        ],
      ),
    );
  }
}
