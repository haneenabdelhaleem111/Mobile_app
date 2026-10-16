import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) => const SplashScreenWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => const SplashScreenWidget(),
        ),
        FFRoute(
          name: SplashScreenWidget.routeName,
          path: SplashScreenWidget.routePath,
          builder: (context, params) => const SplashScreenWidget(),
        ),
        FFRoute(
          name: Onboarding1Widget.routeName,
          path: Onboarding1Widget.routePath,
          builder: (context, params) => const Onboarding1Widget(),
        ),
        FFRoute(
          name: CategoryBrowserWidget.routeName,
          path: CategoryBrowserWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'category_browser')
              : const CategoryBrowserWidget(),
        ),
        FFRoute(
          name: ProductSearchFilterWidget.routeName,
          path: ProductSearchFilterWidget.routePath,
          builder: (context, params) => const ProductSearchFilterWidget(),
        ),
        FFRoute(
          name: ShoppingCartWidget.routeName,
          path: ShoppingCartWidget.routePath,
          builder: (context, params) => const ShoppingCartWidget(),
        ),
        FFRoute(
          name: CheckoutDeliveryWidget.routeName,
          path: CheckoutDeliveryWidget.routePath,
          builder: (context, params) => const CheckoutDeliveryWidget(),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: RegisterWidget.routeName,
          path: RegisterWidget.routePath,
          builder: (context, params) => const RegisterWidget(),
        ),
        FFRoute(
          name: ResetPasswordWidget.routeName,
          path: ResetPasswordWidget.routePath,
          builder: (context, params) => const ResetPasswordWidget(),
        ),
        FFRoute(
          name: EmptyCartWidget.routeName,
          path: EmptyCartWidget.routePath,
          builder: (context, params) => const EmptyCartWidget(),
        ),
        FFRoute(
          name: EmptyWishlistWidget.routeName,
          path: EmptyWishlistWidget.routePath,
          builder: (context, params) => const EmptyWishlistWidget(),
        ),
        FFRoute(
          name: EmptyNoConnectionWidget.routeName,
          path: EmptyNoConnectionWidget.routePath,
          builder: (context, params) => const EmptyNoConnectionWidget(),
        ),
        FFRoute(
          name: EmptyNoOrdersWidget.routeName,
          path: EmptyNoOrdersWidget.routePath,
          builder: (context, params) => const EmptyNoOrdersWidget(),
        ),
        FFRoute(
          name: ServerErrorWidget.routeName,
          path: ServerErrorWidget.routePath,
          builder: (context, params) => const ServerErrorWidget(),
        ),
        FFRoute(
          name: AccountDashboardWidget.routeName,
          path: AccountDashboardWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'AccountDashboard')
              : const AccountDashboardWidget(),
        ),
        FFRoute(
          name: MyProfile2Widget.routeName,
          path: MyProfile2Widget.routePath,
          builder: (context, params) => const MyProfile2Widget(),
        ),
        FFRoute(
          name: EditProfileWidget.routeName,
          path: EditProfileWidget.routePath,
          builder: (context, params) => const EditProfileWidget(),
        ),
        FFRoute(
          name: NotificationsWidget.routeName,
          path: NotificationsWidget.routePath,
          builder: (context, params) => const NotificationsWidget(),
        ),
        FFRoute(
          name: OrderSuccessWidget.routeName,
          path: OrderSuccessWidget.routePath,
          builder: (context, params) => const OrderSuccessWidget(),
        ),
        FFRoute(
          name: WishlistWidget.routeName,
          path: WishlistWidget.routePath,
          builder: (context, params) => const WishlistWidget(),
        ),
        FFRoute(
          name: ProductDetailsWidget.routeName,
          path: ProductDetailsWidget.routePath,
          builder: (context, params) => const ProductDetailsWidget(),
        ),
        FFRoute(
          name: NewScreen4Widget.routeName,
          path: NewScreen4Widget.routePath,
          builder: (context, params) => const NewScreen4Widget(),
        ),
        FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) => const HomeWidget(),
        ),
        FFRoute(
          name: ProductsSearchWidget.routeName,
          path: ProductsSearchWidget.routePath,
          builder: (context, params) => const ProductsSearchWidget(),
        ),
        FFRoute(
          name: DealsWidget.routeName,
          path: DealsWidget.routePath,
          builder: (context, params) => const DealsWidget(),
        ),
        FFRoute(
          name: TermconditionsWidget.routeName,
          path: TermconditionsWidget.routePath,
          builder: (context, params) => const TermconditionsWidget(),
        ),
        FFRoute(
          name: TermsConditionsWidget.routeName,
          path: TermsConditionsWidget.routePath,
          builder: (context, params) => const TermsConditionsWidget(),
        ),
        FFRoute(
          name: BrandsWidget.routeName,
          path: BrandsWidget.routePath,
          builder: (context, params) => const BrandsWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    curve: transitionInfo.transitionType ==
                            PageTransitionType.scale
                        ? const Interval(0.0, 0.5)
                        : Curves.linear,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() =>
      const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
