import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/utils/app_assets.dart';
import 'package:food_app/core/utils/theme/app_theme_data.dart';
import 'package:food_app/features/home/presentation/views/screens/home_screen.dart';
import 'core/service/service_locator.dart';
import 'core/utils/theme/app_theme.dart';
import 'features/base/presentation/bloc/app_bloc.dart';
import 'features/base/presentation/bloc/app_event.dart';
import 'features/base/presentation/bloc/app_state.dart';
import 'features/base/presentation/widgets/bottom_nav_item.dart';
import 'features/home/presentation/bloc/restaurant_bloc/restaurant_bloc.dart';
import 'features/home/presentation/bloc/restaurant_bloc/restaurant_event.dart';

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key, this.content});

  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => sl<AppBloc>()),
        BlocProvider(create: (BuildContext context) {
          final bloc = sl<RestaurantsBloc>();
          if (bloc.state.restaurants.isEmpty) {
            bloc.add(GetRestaurants());
          }
          return bloc;
          //  sl<RestaurantsBloc>()..add(GetRestaurants()),
        }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light.themeData,
        darkTheme: AppTheme.dark.themeData,
        themeMode: ThemeMode.system,
        home: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          context.read<AppBloc>().add(FetchLocationEvent());

          final screens = [
            HomeScreen(
              content: content,
            ),
            const Center(child: Text("Search Screen")),
            const Center(child: Text("Profile Screen")),
            const Center(child: Text("Profile Screen")),
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
                  type: BottomNavigationBarType.fixed,
                  items: [
                    buildNavItem(
                      icon: Icons.home,
                      label: "Home",
                      isSelected: state.currentIndex == 0,
                    ),
                    buildNavItem(
                      icon: Icons.person,
                      label: "Profile",
                      isSelected: state.currentIndex == 1,
                    ),
                    buildNavItem(
                      icon: Icons.shopping_cart,
                      label: "Cart",
                      isSelected: state.currentIndex == 2,
                    ),
                    buildNavItem(
                      icon: Icons.chat,
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
