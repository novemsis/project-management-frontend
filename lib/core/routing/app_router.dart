import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

import '../../account/account_cubit.dart';
import '../../account/account_state.dart';
import '../../features/home/home_page.dart';
import '../../features/login/login_page.dart';
import '../../features/project/project_details_page.dart';
import 'account_router_notifier.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final accountCubit = ref.read(AccountCubit.provider.bloc);

  final refreshNotifier = AccountRouterNotifier(accountCubit);

  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    refreshListenable: refreshNotifier,

    redirect: (context, state) {
      bool isLoggedIn = accountCubit.state is AccountStateLoggedIn;

      final isLoginPage = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoginPage) {
        return '/login';
      }

      if (isLoggedIn && isLoginPage) {
        return '/';
      }
      /*catch (e, stackTrace) {
        debugPrint('REDIRECT ERROR: $e');
        debugPrintStack(stackTrace: stackTrace);
      }*/

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/project/:projectId',
        builder: (context, state) {
          final projectId = state.pathParameters['projectId']!;
          return ProjectDetailsPage(projectId);
        },
      ),
    ],
  );
});
