import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/user_repository.dart';
import 'data/repositories/recycle_repository.dart';
import 'core/services/firebase_auth_service.dart';
import 'core/services/firestore_service.dart';
import 'features/app/bloc/app_bloc.dart';

class EcoScanApp extends StatelessWidget {
  const EcoScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirestoreService();
    final authService = FirebaseAuthService();

    final userRepo = UserRepository(firestore: firestore);
    final recycleRepo = RecycleRepository(firestore: firestore);

    final authRepo = AuthRepository(
      authService: authService,
      firestore: firestore,
      userRepository: userRepo,
    );

    final router = AppRouter.create(authRepository: authRepo);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepo),
        RepositoryProvider.value(value: userRepo),
        RepositoryProvider.value(value: recycleRepo),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(authRepository: authRepo)..add(const AppStarted()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'EcoScan',
          theme: ThemeData(useMaterial3: true),
          routerConfig: router,
        ),
      ),
    );
  }
}