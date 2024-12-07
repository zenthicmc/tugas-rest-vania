import 'package:vania/vania.dart';
import 'package:tugasrest/app/http/controllers/customer_controller.dart';
import 'package:tugasrest/app/http/controllers/order_controller.dart';
import 'package:tugasrest/app/http/controllers/vendor_controller.dart';
import 'package:tugasrest/app/http/controllers/product_controller.dart';
import 'package:tugasrest/app/http/controllers/productnotes_controller.dart';
import 'package:tugasrest/app/http/controllers/orderitems_controller.dart';
import 'package:tugasrest/app/http/middleware/authenticate.dart';
import 'package:tugasrest/app/http/middleware/error_response_middleware.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.get("/customer", customerController.index);
    Router.get("/customer/{id}", customerController.show);
    Router.post("/customer", customerController.store);
    Router.put("/customer/{id}", customerController.update);
    Router.delete("/customer/{id}", customerController.destroy);

    Router.get("/order", orderController.index);
    Router.get("/order/{id}", orderController.show);
    Router.post("/order", orderController.store);
    Router.put("/order/{id}", orderController.update);
    Router.delete("/order/{id}", orderController.destroy);

    Router.get("/vendor", vendorController.index);
    Router.get("/vendor/{id}", vendorController.show);
    Router.post("/vendor", vendorController.store);
    Router.put("/vendor/{id}", vendorController.update);
    Router.delete("/vendor/{id}", vendorController.destroy);

    Router.get("/product", productController.index);
    Router.get("/product/{id}", productController.show);
    Router.post("/product", productController.store);
    Router.put("/product/{id}", productController.update);
    Router.delete("/product/{id}", productController.destroy);

    Router.get("/notes", productNotesController.index);
    Router.get("/notes/{id}", productNotesController.show);
    Router.post("/notes", productNotesController.store);
    Router.put("/notes/{id}", productNotesController.update);
    Router.delete("/notes/{id}", productNotesController.destroy);

    Router.get("/items", orderItemsController.index);
    Router.get("/items/{id}", orderItemsController.show);
    Router.post("/items", orderItemsController.store);
    Router.put("/items/{id}", orderItemsController.update);
    Router.delete("/items/{id}", orderItemsController.destroy);
   
    // Return error code 400
    Router.get('wrong-request',
            () => Response.json({'message': 'Hi wrong request'}))
        .middleware([ErrorResponseMiddleware()]);

    // Return Authenticated user data
    Router.get("/user", () {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);
  }
}