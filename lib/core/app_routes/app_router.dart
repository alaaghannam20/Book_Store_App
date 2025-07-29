import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/models/products_models.dart';
import 'package:bookstore_app/features/Wishlist/presentation/ui/widget/wishlist_screen.dart';
import 'package:bookstore_app/features/auth/book/presentation/ui/books_screen.dart';
import 'package:bookstore_app/features/auth/book/presentation/widgets/all_books_screen.dart';
import 'package:bookstore_app/features/auth/flash_sale/presentation/ui/widget/flash_sale_screen.dart';
import 'package:bookstore_app/features/booksdetails/presentation/ui/widget/books_details_screen.dart';
import 'package:bookstore_app/features/bottom_nav_bar/presentation/ui/widget/bottom_nav_bar_screen.dart';
import 'package:bookstore_app/features/change_password/presentation/ui/change_password_screen.dart';
import 'package:bookstore_app/features/createaccount/presentation/maneger/create_account_cubit.dart';
import 'package:bookstore_app/features/createaccount/presentation/ui/widget/create_account_screen.dart';
import 'package:bookstore_app/features/forget_password/presentation/manager/forget_password_cubit.dart';
import 'package:bookstore_app/features/home/presentation/widget/home_screen.dart';
import 'package:bookstore_app/features/login/presentation/maneger/login_auth_cubit.dart';
import 'package:bookstore_app/features/login/presentation/ui/widget/login_screen.dart';
import 'package:bookstore_app/features/my_cart/presentation/ui/widgets/chech_out_screen.dart';
import 'package:bookstore_app/features/my_cart/presentation/ui/widgets/confirm_order.dart';
import 'package:bookstore_app/features/my_cart/presentation/ui/widgets/my_cart_screen.dart';
import 'package:bookstore_app/features/validate_code/presentation/ui/Verify_code_screen.dart';
import 'package:bookstore_app/features/forget_password/presentation/ui/forget_password_screen.dart';
import 'package:bookstore_app/features/reset_password/presentation/ui/reset_password_screen.dart';
import 'package:bookstore_app/features/auth/profile/presentation/ui/profile_screen.dart';
import 'package:bookstore_app/features/splash/presentation/ui/widget/splah_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
    final bool withFade = (settings.arguments is Map &&
            (settings.arguments as Map).containsKey('withFade'))
        ? (settings.arguments as Map)['withFade'] == true
        : false;

    switch (settings.name) {
      //Splash Screen
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());

      //Login Screen
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (_) => LoginCubit(),
                  child: LoginScreen(),
                ));

      //create Account Screen
      case Routes.createAccountScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const CreateAccountScreen(),
              )
            : MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => CreateAccountCubit(),
                  child: const CreateAccountScreen(),
                ),
              );

      //Home Screen
      case Routes.homeScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomeScreen(),
              )
            : MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              );

      //Forget Password Screen
      case Routes.forgetpasswordScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BlocProvider(
                  create: (_) => ForgetPasswordCubit(),
                  child: const ForgetPasswordScreen(),
                ),
              )
            : MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => ForgetPasswordCubit(),
                  child: const ForgetPasswordScreen(),
                ),
              );

      //Validate Code Screen
      case Routes.verifyCodeScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    VerifyCodeScreen(
                  email: settings.arguments as String? ?? "",
                ),
              )
            : MaterialPageRoute(
                builder: (context) => VerifyCodeScreen(
                  email: settings.arguments as String? ?? "",
                ),
              );

      //Reset Password Screen
      case Routes.resetpasswordScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ResetPasswordScreen(
                  code: settings.arguments as String,
                ),
              )
            : MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(
                  code: settings.arguments as String,
                ),
              );

      //Cheack Screen
      case Routes.finishCheckScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const CheckPasswordScreen(),
              )
            : MaterialPageRoute(
                builder: (context) => const CheckPasswordScreen(),
              );

      //Profile Screen
      case Routes.profileScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfileScreen(),
              )
            : MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              );

      //Book Screen
      case Routes.bookScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const BooksScreen(),
              )
            : MaterialPageRoute(
                builder: (context) => const BooksScreen(),
              );

//BottomNavBar
      case Routes.bottomNavBarScreen:
        return MaterialPageRoute(builder: (context) => BottomNavBar());

        case Routes.wishListScreen:
        return MaterialPageRoute(builder: (context) => WishlistScreen());

//BooksDetailsScreen
      case Routes.bookDetailsScreen:
        final bookId = settings.arguments as int;
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BooksDetailsScreen(booksId: bookId),
              )
            : MaterialPageRoute(
                builder: (context) => BooksDetailsScreen(booksId: bookId),
              );

      //All Books Screen
      case Routes.allBooksScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AllBooksScreen(),
              )
            : MaterialPageRoute(
                builder: (context) => AllBooksScreen(),
              );

      //FalshSale Screen
      case Routes.flashSaleScreen:
       final args = settings.arguments;
  final books = (args is List<Products>) ? args : <Products>[];
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FlashSaleScreen(books: books),
              )
            : MaterialPageRoute(
                builder: (context) => FlashSaleScreen(books: books),
              );

              
      //My Cart Screen
      case Routes.myCartScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MyCartScreen(),
              )
            : MaterialPageRoute(
                builder: (context) => MyCartScreen(),
              );

                 //Confirm Order Screen
      case Routes.confirmOrderScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ConfirmOrder(),
              )
            : MaterialPageRoute(
                builder: (context) => ConfirmOrder(),
              );

              
              //ChechOutScreen
              case Routes.chechOutScreen:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder: (context, animation, _, child) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ChechOutScreen(),
              )
            : MaterialPageRoute(
                builder: (context) => ChechOutScreen(),
              );
    }

    

    return null;
  };
}
