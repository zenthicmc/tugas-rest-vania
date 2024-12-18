import 'package:vania/vania.dart';
import 'package:tugasrest/app/models/users.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    request.validate({
      'name': 'required',
      'email': 'required|email',
      'password': 'required|confirmed'
    });

    final user = Users().query().where('email', '=', request.body['email']);

    if (await user.first() != null) {
      return Response.json({'message': 'Email already exists'});
    }

    await Users().query().insert({
      'name': request.body['name'],
      'email': request.body['email'],
      'password': Hash().make(request.body['password'])
    });

    return Response.json({'message': 'User registered'});
  }

  Future<Response> login(Request request) async {
    request.validate({'email': 'required|email', 'password': 'required'});

    final user = Users().query().where('email', '=', request.body['email']);

    final userData = await user.first();

    if (userData == null) {
      return Response.json({'message': 'User not found'});
    }

    if (!Hash().verify(request.body['password'], userData['password'])) {
      return Response.json({'message': 'Password is incorrect'});
    }

    Map<String, dynamic> token = await Auth()
      .login(userData)
      .createToken(expiresIn: Duration(days: 1), withRefreshToken: true);

    // print token to cmd
    print(token);

    return Response.json({
      'message': 'Login success',
      'data': token,
    });
  }
}

final AuthController authController = AuthController();
