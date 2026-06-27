import 'package:flutter/widgets.dart';

/// Global navigator key used for navigation triggered outside the widget tree,
/// such as taps on push notifications handled by the messaging service.
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();
