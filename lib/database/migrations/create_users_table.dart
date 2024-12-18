import 'package:vania/vania.dart';

class CreateUsersTable extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('users', () {
      id();
      string('name', length: 100);
      string('email', length: 200);
      string('password', length: 255);
      timeStamp('deleted_at', nullable: true);
      timeStamps();
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('users');
  }
}
