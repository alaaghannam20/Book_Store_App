import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';
import 'package:bookstore_app/core/services/networking/dio_factory.dart';
import 'package:bookstore_app/features/Wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:bookstore_app/features/book_store.dart';
import 'package:bookstore_app/features/createaccount/presentation/maneger/create_account_cubit.dart';
import 'package:bookstore_app/features/forget_password/presentation/manager/forget_password_cubit.dart';
import 'package:bookstore_app/features/login/presentation/maneger/login_auth_cubit.dart';
import 'package:bookstore_app/features/my_cart/data/my_cart_repo.dart';
import 'package:bookstore_app/features/my_cart/presentation/manager/my_cart_cubit.dart';
import 'package:bookstore_app/features/reset_password/presentation/manager/reset_password_cubit.dart';
import 'package:bookstore_app/features/validate_code/presentation/manager/validate_code_cubit.dart';
import 'package:bookstore_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefsHelper.init();
  DioFactory.init();

  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<CreateAccountCubit>(
          create: (context) => CreateAccountCubit(),
        ),
         BlocProvider<ForgetPasswordCubit>(
          create: (context) => ForgetPasswordCubit(),
        ),
        BlocProvider<VerifyCodeCubit>(
          create: (context) => VerifyCodeCubit(),
        ),
        BlocProvider<ResetPasswordCubit>(
          create: (context) => ResetPasswordCubit(),
        ),
         BlocProvider<WishlistCubit>(   
        create: (context) => WishlistCubit(),
      ),
      BlocProvider<MyCartCubit>(
      create: (context) => MyCartCubit(MyCartRepo(), context),
    ),
      ],
      child: const BookStore(),
    ),
  );
}
