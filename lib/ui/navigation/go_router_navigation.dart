import 'package:barber_shop/ui/navigation/route_name.dart';
import 'package:barber_shop/ui/navigation/route_path.dart';
import 'package:barber_shop/ui/widgets/barber_screen_widget/factories/barber_screen_factories.dart';
import 'package:barber_shop/ui/widgets/customer_screen_widget/factories/customer_screen_factory.dart';
import 'package:barber_shop/ui/widgets/start_screen/start_screen_widget.dart';
import 'package:go_router/go_router.dart';

final _customerScreenFactory = CustomerScreenFactory.instance;
final _barberScreenFactory = BarberScreenFactory.instance;

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: RoutePath.startScreenPath,
    name: RouteName.startScreen,
    builder: (context, state) => StartScreenWidget(),
  ),
  GoRoute(
      path: RoutePath.loaderPath,
      name: RouteName.loaderScreen,
      builder: (context, state) =>
          _customerScreenFactory.makeLoaderScreen(context),
      routes: [
        GoRoute(
          path: RoutePath.customerLoginPath,
          name: RouteName.customerLoginScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerLoginWidget(),
        ),
        GoRoute(
          path: RoutePath.customerRegisterPath,
          name: RouteName.customerRegisterScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerRegisterScreen(),
        ),
        GoRoute(
          path: RoutePath.customerResetPasswordPath,
          name: RouteName.customerResetPasswordScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeForgotPasswordScreen(),
        ),
        GoRoute(
          path: RoutePath.customerMainPath,
          name: RouteName.customerMainScreen,
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerHiddenMenuWidget(),
        ),
        GoRoute(
          path: RoutePath.barberLoginPath,
          name: RouteName.barberLoginScreen,
          builder: (context, state) => _barberScreenFactory.makeLoginScreen(),
        ),
        GoRoute(
          path: RoutePath.barberResetPasswordPath,
          name: RouteName.barberResetPasswordScreen,
          builder: (context, state) =>
              _barberScreenFactory.makeForgotPasswordScreen(),
        ),
        GoRoute(
          path: RoutePath.barberRegisterPath,
          name: RouteName.barberRegisterScreen,
          builder: (context, state) =>
              _barberScreenFactory.makeRegisterScreen(),
        ),
        GoRoute(
          path: RoutePath.barberMainPath,
          name: RouteName.barberMainScreen,
          builder: (context, state) =>
              _barberScreenFactory.makeMainScreenWidget(),
        ),
      ]),
]);
