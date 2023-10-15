import 'package:go_router/go_router.dart';
import 'package:notes/domain/domain.dart';
import 'package:notes/presentation/screens/home_screen/home_screen.dart';
import 'package:notes/presentation/screens/note_screen/note_screen.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
        path: "/",
        builder: (_, __) {
          return const HomeScreen();
        },
        routes: const []),
    GoRoute(
      path: "/edit-note",
      builder: (_, state) {
        final noteEntity =
            state.extra != null ? state.extra as NoteEntity : null;
        return NoteScreen(noteEntity);
      },
    ),
  ],
);
