import 'package:barber_shop/ui/widgets/barber_screen_widget/factories/barber_screen_factories.dart';
import 'package:barber_shop/ui/widgets/customer_screen_widget/factories/customer_screen_factory.dart';
import 'package:barber_shop/ui/widgets/loader/loader.dart';
import 'package:barber_shop/ui/widgets/start_screen/start_screen_widget.dart';
import 'package:go_router/go_router.dart';

import '../widgets/loader/loader_widget.dart';

final _customerScreenFactory = CustomerScreenFactory.instance;
final _barberScreenFactory = BarberScreenFactory.instance;

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/startScreen',
    name: 'startScreen',
    builder: (context, state) => StartScreenWidget(),
  ),
  GoRoute(
      path: '/',
      name: '/',
      builder: (context, state) => Loader.instance.makeLoaderScreen(context),
      routes: [
        GoRoute(
          path: 'customerLogin',
          name: 'customerLogin',
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerLoginWidget(),
        ),
        GoRoute(
          path: 'customerLogin/customerRegister',
          name: 'customerRegister',
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerRegisterScreen(),
        ),
        GoRoute(
          path: "customerMainScreen",
          name: 'customerMainScreen',
          builder: (context, state) =>
              _customerScreenFactory.makeCustomerHiddenMenuWidget(),
        ),

        GoRoute(
          path: 'barberLogin',
          name: 'barberLogin',
          builder: (context, state) => _barberScreenFactory.makeLoginScreen(),
        ),
        GoRoute(
          path: 'barberRegister',
          name: 'barberRegister',
          builder: (context, state) =>
              _barberScreenFactory.makeRegisterScreen(),
        ),
        GoRoute(
          path: "barberMainScreen",
          name: 'barberMainScreen',
          builder: (context, state) =>
              _barberScreenFactory.makeMainScreenWidget(),
        ),
      ]),
]);

/*
final GoRouter router = GoRouter(
    routes: [
  GoRoute(
      path: '/',
      name: '/',
      builder: (context, state) => LoaderWidget(),
      routes: [
        GoRoute(
            path: '/startScreen',
            name: 'startScreen',
            builder: (context, state) => const StartScreenWidget(),
            routes: [
              GoRoute(
                  path: '/startScreen/customerLogin',
                  name: 'customerLogin',
                  builder: (context, state) => const CustomerLoginWidget(),
                  routes: [
                    GoRoute(
                      path: '/startScreen/customerRegister',
                      name: 'customerRegister',
                      builder: (context, state) =>
                          const CustomerRegisterWidget(),
                    ),
                    GoRoute(
                      path: "/customerMainScreen",
                      name: 'customerMainScreen',
                      builder: (context, state) =>
                          const CustomerHiddenMenuWidget(),
                    ),
                  ]),
              GoRoute(
                  path: '/startScreen/barberLogin',
                  name: 'barberLogin',
                  builder: (context, state) => const CustomerLoginWidget(),
                  routes: [
                    GoRoute(
                      path: '/startScreen/barberRegister',
                      name: 'barberRegister',
                      builder: (context, state) => const BarberRegisterWidget(),
                    ),
                    GoRoute(
                      path: "/barberMainScreen",
                      name: 'barberMainScreen',
                      builder: (context, state) =>
                          const BarberHiddenMenuWidget(),
                    ),
                  ]),
            ]),
      ]
    ),
]);
 */
