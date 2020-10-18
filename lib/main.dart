import 'package:arrow_log/factory.dart';
import 'package:arrow_log/pages/session_overview.dart';
import 'package:arrow_log/utils/theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ArrowLogFactory arrowLogFactory = ArrowLogFactory();
  await arrowLogFactory.initializeServices();

  runApp(ArrowLogApp(
    arrowLogFactory: arrowLogFactory,
  ));
}

class ArrowLogApp extends StatelessWidget {
  final ArrowLogFactory arrowLogFactory;

  ArrowLogApp({
    @required this.arrowLogFactory,
  });

  @override
  Widget build(BuildContext context) {
    return arrowLogFactory.initializeRepositories(
      child: arrowLogFactory.initializeBlocs(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ArrowLog',
          theme: ThemeUtil.lightTheme(),
          darkTheme: ThemeUtil.darkTheme(),
          themeMode: ThemeMode.system,
          home: SessionOverviewPage(),
        ),
      ),
    );
  }
}
