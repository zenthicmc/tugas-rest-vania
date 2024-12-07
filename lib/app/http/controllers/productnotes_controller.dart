import 'package:vania/vania.dart';
import 'package:tugasrest/app/models/productnotes.dart';
import 'package:tugasrest/app/models/products.dart';

class ProductNotesController extends Controller {
  Future<Response> index() async {
    final notes = await ProductNotes().query().get();
    return Response.json({'message': 'Data found', 'data': notes});
  }

  Future<Response> store(Request request) async {
    final product = await Products().query().where('prod_id', '=', request.body['prod_id']).first();
    if (product == null) {
      return Response.json({'message': 'Product not found'});
    }

    await ProductNotes().query().insert({
      'note_id' : request.body['note_id'],
      'prod_id' : request.body['prod_id'],
      'note_date' : request.body['note_date'],
      'note_text' : request.body['note_text'],
    });

    return Response.json({'message': 'Data inserted'});
  }

  Future<Response> show(String id) async {
    final note = await ProductNotes().query().where('note_id', '=', id).first();

    if (note == null) {
      return Response.json({'message': 'Data not found'});
    }

    return Response.json({'message': 'Data found', 'data': note});
  }

  Future<Response> update(Request request, String id) async {
    final note = await ProductNotes().query().where('note_id', '=', id).first();
    if (note == null) {
      return Response.json({'message': 'Data not found'});
    }

    await ProductNotes().query().where('note_id', '=', id).update({
      'prod_id' : request.body['prod_id'],
      'note_date' : request.body['note_date'],
      'note_text' : request.body['note_text'],
    });

    return Response.json({'message': 'Data updated'});
  }

  Future<Response> destroy(String id) async {
    await ProductNotes().query().where('note_id', '=', id).delete();
    return Response.json({'message': 'Data deleted'});
  }
}

final ProductNotesController productNotesController = ProductNotesController();
