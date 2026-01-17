import 'package:go_router/go_router.dart';

// Placeholder screens
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/auth/adaptive_auth_screen.dart';
import '../../presentation/screens/categories/categories_screen.dart';
import '../../presentation/screens/tasks/add_task_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/auth', // Start with combined auth
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AdaptiveAuthScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoriesScreen(),
      ),
      GoRoute(
        path: '/add-task',
        builder: (context, state) => const AddTaskScreen(),
      ),
    ],
  );
}
