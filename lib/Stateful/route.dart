import 'package:dorun_2th_flutter_study/Stateful/screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => StatefulApp(),
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) => CreatePage(),
    )
  ],
);