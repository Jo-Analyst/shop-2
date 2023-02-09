import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/produtc_item.dart';
import 'package:shop/models/product_list.dart';

import '../components/app_drawer.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList product = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerenciar Produtos"),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: product.items.length,
          itemBuilder: (ctx, i) => Column(
            children: [
              ProductItem(product.items[i]),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
