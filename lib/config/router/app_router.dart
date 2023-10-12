import 'package:go_router/go_router.dart';
import 'package:notes/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      path: "/home",
      builder: (_, __) {
        return HomeScreen();
      },
    )
  ],
);
