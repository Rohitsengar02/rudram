import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/theme_provider.dart';

// Lenis-like smooth scroll physics
class LenisScrollPhysics extends ScrollPhysics {
  const LenisScrollPhysics({super.parent});

  @override
  LenisScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return LenisScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Smooth out the scroll offset
    return offset * 0.8; // Damping factor for smoother scrolling
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    // Soft boundary with elastic effect
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      return value - position.pixels;
    }
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      return value - position.pixels;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels) {
      return value - position.minScrollExtent;
    }
    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) {
      return value - position.maxScrollExtent;
    }
    return 0.0;
  }

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final tolerance = toleranceFor(position);

    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      return ScrollSpringSimulation(
        SpringDescription.withDampingRatio(
          mass: 0.5,
          stiffness: 100.0,
          ratio: 1.1,
        ),
        position.pixels,
        position.pixels + velocity * 0.3, // Reduced velocity for smoothness
        velocity * 0.5, // Damped velocity
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  SpringDescription get spring => SpringDescription.withDampingRatio(
    mass: 0.5,
    stiffness: 100.0,
    ratio: 1.1,
  );

  @override
  double get minFlingVelocity => 50.0;

  @override
  double get maxFlingVelocity => 8000.0;
}

// Custom scroll behavior with Lenis-like physics
class LenisScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const LenisScrollPhysics();
  }

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // Hide scrollbar for cleaner look
    return child;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Ecommerce App',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeProvider.lightTheme,
          darkTheme: ThemeProvider.darkTheme,
          scrollBehavior: LenisScrollBehavior(),
          home: const HomeScreen(),
        );
      },
    );
  }
}
