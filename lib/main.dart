import 'package:flutter/material.dart';

import 'app.dart';
import 'inject_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const App());
}




