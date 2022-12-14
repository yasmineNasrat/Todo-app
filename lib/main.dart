import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laila_flutter/layout/todo_home_layout.dart';
import 'package:laila_flutter/shared/cubitt/cubit.dart';
import 'package:laila_flutter/shared/cubitt/states.dart';
import 'package:laila_flutter/shared/local/cache.dart';
import 'shared/bloc__observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBooleanData('dark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext cxt)
  {
    return BlocProvider(
      create: (context) => AppCubit()..SwitchDarkMode(cachedIsDark: isDark),
      child: BlocConsumer<AppCubit,AppStates>(
          builder: (context,state){
            return MaterialApp(
              home: HomeLayout(),
              debugShowCheckedModeBanner:false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.grey[100],
                primarySwatch: Colors.amber,
              ),
              themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              darkTheme: ThemeData(
                primarySwatch: Colors.blue,
                scaffoldBackgroundColor: Colors.black,
              ),
            );
          },
          listener: (context,state)=>{

          },
      ),
    );
  }

}

