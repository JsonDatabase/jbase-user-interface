import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jbase_user_interface/src/interface/screen/home_screen.dart';
import 'package:jbase_user_interface/src/state_managment/control_plane_cubit.dart';

class JBase extends StatelessWidget {
  const JBase({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ControlPlaneCubit(),
      child: MaterialApp(
        title: 'JBase',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            applyElevationOverlayColor: false,
            brightness: Brightness.light,
            colorScheme: const ColorScheme(
                background: Color(0xfff8f5f8),
                brightness: Brightness.light,
                error: Color(0xffba1a1a),
                errorContainer: Color(0xffffdad6),
                inversePrimary: Color(0xff9ecaff),
                inverseSurface: Color(0xff2f3033),
                onBackground: Color(0xff00174c),
                onError: Color(0xffffffff),
                onErrorContainer: Color(0xff410002),
                onInverseSurface: Color(0xfff1f0f4),
                onPrimary: Color(0xffffffff),
                onPrimaryContainer: Color(0xff002112),
                onSecondary: Color(0xffffff),
                onSecondaryContainer: Color(0xff002204),
                onSurface: Color(0xff1a1c1e),
                onSurfaceVariant: Color(0xff43474e),
                onTertiary: Color(0xffffffff),
                onTertiaryContainer: Color(0xff002117),
                outline: Color(0xff73777f),
                primary: Color(0xff00b273),
                primaryContainer: Color(0xffa4f4c4),
                secondary: Color(0xff23b03c),
                secondaryContainer: Color(0xffb6f2af),
                shadow: Color(0xff000000),
                surface: Color(0xfffdfcff),
                surfaceTint: Color(0xff0061a4),
                surfaceVariant: Color(0xffdfe2eb),
                tertiary: Color(0xff0e6c53),
                tertiaryContainer: Color(0xff9bf4d2)),
            primaryTextTheme: const TextTheme(
                bodyLarge: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 0.5,
                ),
                bodyMedium: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 0.25,
                ),
                bodySmall: TextStyle(
                  color: Color(0xb3ffffff),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 0.4,
                ),
                displayLarge: TextStyle(
                  color: Color(0xb3ffffff),
                  fontSize: 96,
                  fontWeight: FontWeight.w300,
                  inherit: false,
                  letterSpacing: -1.5,
                ),
                displayMedium: TextStyle(
                  color: Color(0xb3ffffff),
                  fontSize: 60,
                  fontWeight: FontWeight.w300,
                  inherit: false,
                  letterSpacing: -0.5,
                ),
                displaySmall: TextStyle(
                  color: Color(0xb3ffffff),
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 0,
                ),
                headlineLarge: TextStyle(
                  color: Color(0xb3ffffff),
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 0.25,
                ),
                headlineMedium: TextStyle(
                  color: Color(0xb3ffffff),
                  fontSize: 34,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 0.25,
                ),
                headlineSmall: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 0,
                ),
                labelLarge: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  inherit: false,
                  letterSpacing: 1.25,
                ),
                labelMedium: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 1.5,
                ),
                labelSmall: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 1.5,
                ),
                titleLarge: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  inherit: false,
                  letterSpacing: 0.15,
                ),
                titleMedium: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  inherit: false,
                  letterSpacing: 0.15,
                ),
                titleSmall: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  inherit: false,
                  letterSpacing: 0.1,
                )),
            useMaterial3: false,
            visualDensity: VisualDensity.compact),
        home: const HomeScreen(),
      ),
    );
  }
}
