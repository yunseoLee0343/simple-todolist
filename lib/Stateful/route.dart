import 'package:dorun_2th_flutter_study/Stateful/screens.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => StatefulApp(),
    ),
    GoRoute(
      path: '/create/:items/:subItems',
      name: 'create',
      builder: (context, state) {
        // for passing data from StatefulApp(Home) to CreatePage
        List<String> items = List<String>.from((state.pathParameters['items']?.split(",")) ?? []);
        List<String> subItems = List<String>.from((state.pathParameters['subItems']?.split("|")) ?? []);

        return CreatePage(items: items, subItems: subItems,);
      },
    )
  ],
);