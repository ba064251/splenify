import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class APIServices{

  Future<void> getAllProducts()async{
    var request = http.Request('GET', Uri.parse('https://dummyjson.com/products'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      Map map = jsonDecode(res);
      List<dynamic> productData = map['products'];
      final _productBox = Hive.box('product');
      _productBox.put('products', productData);
    }
    else {
      response.reasonPhrase;
    }

  }

  Future getSpecificProducts(id)async{
    var request = http.Request('GET', Uri.parse('https://dummyjson.com/products/$id'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return res;
    }
    else {
      var error = response.reasonPhrase;
      return error;
    }

  }

  Future<void> getCategory()async {
    var request = http.Request('GET', Uri.parse('https://dummyjson.com/products/categories'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      List<dynamic> categoryData = jsonDecode(res);
      final _categoryBox = Hive.box('category');
      _categoryBox.put('categories', categoryData);
    }
    else {
      response.reasonPhrase;
    }

  }

}