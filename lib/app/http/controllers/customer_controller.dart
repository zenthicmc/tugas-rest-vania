import 'package:vania/vania.dart';
import 'package:tugasrest/app/models/customers.dart';

class CustomerController extends Controller {
  Future<Response> index() async {
    final customers = await Customers().query().get();
    return Response.json({'message': 'Data found', 'data': customers});
  }

  Future<Response> store(Request request) async {
    await Customers()
      .query()
      .insert({
        'cust_id': request.body['cust_id'],
        'cust_name': request.body['cust_name'],
        'cust_address': request.body['cust_address'],
        'cust_city': request.body['cust_city'],
        'cust_state': request.body['cust_state'],
        'cust_zip': request.body['cust_zip'],
        'cust_country': request.body['cust_country'],
        'cust_telp': request.body['cust_telp']
      });

    return Response.json({'message': 'Data inserted'});
  }

  Future<Response> show(String id) async {
    final customer = await Customers().query().where('cust_id', '=', id).first();
    
    if (customer == null) {
      return Response.json({'message': 'Data not found'});
    }

    return Response.json({'message': 'Data found', 'data': customer});
  }

  Future<Response> update(Request request, String id) async {
    await Customers()
      .query()
      .where('cust_id', '=', id)
      .update({
        'cust_name': request.body['cust_name'],
        'cust_address': request.body['cust_address'],
        'cust_city': request.body['cust_city'],
        'cust_state': request.body['cust_state'],
        'cust_zip': request.body['cust_zip'],
        'cust_country': request.body['cust_country'],
        'cust_telp': request.body['cust_telp']
      });

    return Response.json({'message': 'Data updated'});
  }

  Future<Response> destroy(String id) async {
    await Customers().query().where('cust_id', '=', id).delete();

    return Response.json({'message': 'Data deleted'});
  }
}

final CustomerController customerController = CustomerController();
