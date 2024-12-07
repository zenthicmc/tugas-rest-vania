import 'package:tugasrest/app/models/products.dart';
import 'package:vania/vania.dart';
import 'package:tugasrest/app/models/vendors.dart';

class ProductController extends Controller {
  Future<Response> index() async {
    final products = await Products().query().get();
    return Response.json({'message': 'Data found', 'data': products});
  }

  Future<Response> store(Request request) async {
    // check if vend_id exists
    final vendor = await Vendors().query().where('vend_id', '=', request.body['vend_id']).first();
    if (vendor == null) {
      return Response.json({'message': 'Vendor not found'});
    }

    await Products().query().insert({
      'prod_id': request.body['prod_id'],
      'vend_id': request.body['vend_id'],
      'prod_name': request.body['prod_name'],
      'prod_price': request.body['prod_price'],
      'prod_desc': request.body['prod_desc'],
    });

    return Response.json({'message': 'Data inserted'});
  }

  Future<Response> show(String id) async {
    final product = await Products().query().where('prod_id', '=', id).first();

    if (product == null) {
      return Response.json({'message': 'Data not found'});
    }

    return Response.json({'message': 'Data found', 'data': product});
  }

  Future<Response> update(Request request, String id) async {
    final product = await Products().query().where('prod_id', '=', id).first();
    
    if (product == null) {
      return Response.json({'message': 'Data not found'});
    }

    await Products().query().where('prod_id', '=', id).update({
      'vend_id': request.body['vend_id'],
      'prod_name': request.body['prod_name'],
      'prod_price': request.body['prod_price'],
      'prod_desc': request.body['prod_desc'],
    });

    return Response.json({'message': 'Data updated'});
  }

  Future<Response> destroy(String id) async {
    await Products().query().where('prod_id', '=', id).delete();

    return Response.json({'message': 'Data deleted'});
  }
}

final ProductController productController = ProductController();
