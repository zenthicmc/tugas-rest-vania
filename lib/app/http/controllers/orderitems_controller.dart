import 'package:vania/vania.dart';
import 'package:tugasrest/app/models/orders.dart';
import 'package:tugasrest/app/models/orderitems.dart';
import 'package:tugasrest/app/models/products.dart';

class OrderItemsController extends Controller {
  Future<Response> index() async {
    final items = await OrderItems().query().get();
    return Response.json({'message': 'Data found', 'data': items});
  }

  Future<Response> store(Request request) async {
    // check if order_num exists
    final order = await Orders().query().where('order_num', '=', request.body['order_num']).first();
    if (order == null) {
      return Response.json({'message': 'Order not found'});
    }

    // check if prod_id exists
    final product = await Products().query().where('prod_id', '=', request.body['prod_id']).first();
    if (product == null) {
      return Response.json({'message': 'Product not found'});
    }

    await OrderItems().query().insert({
      'order_item' : request.body['order_item'],
      'order_num' : request.body['order_num'],
      'prod_id' : request.body['prod_id'],
      'quantity' : request.body['quantity'],
      'size' : request.body['size'],
    });

    return Response.json({'message': 'Data inserted'});
  }

  Future<Response> show(int id) async {
    final item = await OrderItems().query().where('order_item', '=', id).first();

    if (item == null) {
      return Response.json({'message': 'Data not found'});
    }

    return Response.json({'message': 'Data found', 'data': item});
  }

  Future<Response> update(Request request, int id) async {
    final item = await OrderItems().query().where('order_item', '=', id).first();
    if (item == null) {
      return Response.json({'message': 'Data not found'});
    }

    await OrderItems().query().where('order_item', '=', id).update({
      'order_num' : request.body['order_num'],
      'prod_id' : request.body['prod_id'],
      'quantity' : request.body['quantity'],
      'size' : request.body['size'],
    });

    return Response.json({'message': 'Data updated'});
  }

  Future<Response> destroy(int id) async {
    await OrderItems().query().where('order_item', '=', id).delete();
    return Response.json({'message': 'Data deleted'});
  }
}

final OrderItemsController orderItemsController = OrderItemsController();
