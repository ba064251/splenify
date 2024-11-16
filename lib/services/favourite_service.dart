import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavouriteService{
  late Box<List> favourite;
  Future<void> addProduct(Map product, BuildContext context) async {
    // Get the current list of products
    final _favourite = Hive.box('favourite');
    _favourite.put('favourite', [product]);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Favourite Added')));

    // print('Product added: $product');
  }
}