import 'package:coffee_shop/bloc/coffee/coffee_bloc.dart';
import 'package:coffee_shop/bloc/order/order_bloc.dart';
import 'package:coffee_shop/cubit/page_view_cubit.dart';
import 'package:coffee_shop/data/local/storage_repository.dart';
import 'package:coffee_shop/repository/coffee_repo.dart';
import 'package:coffee_shop/repository/order_repo.dart';
import 'package:coffee_shop/ui/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstance();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => CoffeeRepo()),
        RepositoryProvider(create: (context) => OrderRepo()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CoffeeBloc(coffeeRepo: context.read<CoffeeRepo>()),
          ),
          BlocProvider(
            create: (context) =>
                OrderBloc(orderRepo: context.read<OrderRepo>()),
          ),
          BlocProvider(create: (context) => PageViewCubit()),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
