import 'package:vania/vania.dart';
import 'package:tugasrest/app/models/orders.dart';
import 'package:tugasrest/app/models/customers.dart';

class OrderController extends Controller {
  Future<Response> index() async {
    final orders = await Orders().query()
        .join('customers', 'customers.cust_id', '=', 'orders.cust_id')
        .join('orderitems', 'orderitems.order_num', '=', 'orders.order_num')
        .join('products', 'products.prod_id', '=', 'orderitems.prod_id')
        .join('productnotes', 'productnotes.prod_id', '=', 'products.prod_id')
        .get();
    return Response.json({'message': 'Data found', 'data': orders});
  }

  Future<Response> store(Request request) async {
    // check if cust_id exists
    final customer = await Customers().query().where('cust_id', '=', request.body['cust_id']).first();
    if (customer == null) {
      return Response.json({'message': 'Customer not found'});
    }

    await Orders().query().insert({
      'order_num': request.body['order_num'],
      'cust_id': request.body['cust_id'],
      'order_date': request.body['order_date'],
    });

    return Response.json({'message': 'Data inserted'});
  }

  Future<Response> show(int id) async {
    final order = await Orders().query().where('orders.order_num', '=', id)
    .join('customers', 'customers.cust_id', '=', 'orders.cust_id')
        .join('orderitems', 'orderitems.order_num', '=', 'orders.order_num')
        .join('products', 'products.prod_id', '=', 'orderitems.prod_id')
        .join('productnotes', 'productnotes.prod_id', '=', 'products.prod_id')
        .first();

    if (order == null) {
      return Response.json({'message': 'Data not found'});
    }

    return Response.json({'message': 'Data found', 'data': order});
  }

  Future<Response> update(Request request, int id) async {
    final order = await Orders().query().where('order_num', '=', id).update({
      'cust_id': request.body['cust_id'],
      'order_date': request.body['order_date'],
    });

    if (order == 0) {
      return Response.json({'message': 'Data not found'});
    }

    return Response.json({'message': 'Data updated'});
  }

  Future<Response> destroy(int id) async {
    await Orders().query().where('order_num', '=', id).delete();

    return Response.json({'message': 'Data deleted'});
  }
}

final OrderController orderController = OrderController();
