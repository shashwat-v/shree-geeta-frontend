import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shree_geeta/features/auth/provider/auth_provider.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ];
}
