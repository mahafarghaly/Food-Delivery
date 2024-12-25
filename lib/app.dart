import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/app_assets.dart';
import 'package:food_app/core/utils/theme/app_theme_data.dart';
import 'package:food_app/features/home/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:food_app/features/home/presentation/views/screens/home_screen.dart';
import 'package:food_app/features/home/presentation/views/screens/search/search_result_screen.dart';
import 'core/service/service_locator.dart';
import 'core/utils/theme/app_theme.dart';
import 'features/base/presentation/bloc/app_bloc.dart';
import 'features/base/presentation/bloc/app_event.dart';
import 'features/base/presentation/bloc/app_state.dart';
import 'features/base/presentation/widgets/bottom_nav_item.dart';
import 'features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'features/home/presentation/bloc/restaurant_bloc/restaurant_event.dart';

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => sl<AppBloc>()),
        BlocProvider(create: (BuildContext context)=>  sl<RestaurantsBloc>()..add(GetRestaurants()),
        ),
        BlocProvider(create: (BuildContext context)=>  sl<SearchBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light.themeData,
        darkTheme: AppTheme.dark.themeData,
        themeMode: ThemeMode.system,
        home: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          context.read<AppBloc>().add(FetchLocationEvent());

          final screens = [
          const HomeScreen(),
            const Center(child: Text("Profile Screen")),
            const Center(child: Text("Cart Screen")),
            const Center(child: Text("Chat Screen")),
          ];
          return Scaffold(
            body: Stack(
              alignment: Alignment.topRight,
              children: [
                Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(AppAssets.homeBackgroundImage)),
                screens[state.currentIndex],
              ],
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 100,
                    spreadRadius: 1,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              margin: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BottomNavigationBar(
                  currentIndex: state.currentIndex,
                  onTap: (index) {
                    context
                        .read<AppBloc>()
                        .add(ChangeBottomNavIndexEvent(index));
                  },
                  items: [
                    buildNavItem(
                      context,
                      icon: AppAssets.home,
                      label: "Home",
                      isSelected: state.currentIndex == 0,
                    ),
                    buildNavItem(
                      context,
                      icon: AppAssets.profile,
                      label: "Profile",
                      isSelected: state.currentIndex == 1,
                    ),
                    buildNavItem(
                      context,
                      icon: AppAssets.buy,
                      label: "Cart",
                      isSelected: state.currentIndex == 2,
                    ),
                    buildNavItem(context,
                      icon: AppAssets.chat,
                      label: "Chat",
                      isSelected: state.currentIndex == 3,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
