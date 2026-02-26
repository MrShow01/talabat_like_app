import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class BlocObserv extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('Bloc created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('Bloc: ${bloc.runtimeType}, Change: $change');
  }
}
