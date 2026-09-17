import 'dart:js_interop';

@JS('HeaderScroll')
extension type HeaderScroll._(JSObject _) implements JSObject {
  // Core methods
  external void init();
  external void destroy();

  // Scroll information
  external double getScrollPosition();
  external bool isHeaderScrolled();
  external String getHeaderClassName();

  // Configuration
  external void setThreshold(double threshold);
  external void setSelector(String selector);
}

@JS('HeaderScroll')
external HeaderScroll get headerScroll;

@JS('CustomScroll')
extension type CustomScroll._(JSObject _) implements JSObject {
  // Basic scroll methods
  external void toTop([double duration]);
  external void toBottom([double duration]);
  external void toPosition(double position, [double duration]);
  external void toElement(String selector, [double duration, double offset]);
  
  // Utility methods
  external double getCurrentPosition();
  external bool isAtTop();
  external bool isAtBottom();
  external void setDefaultDuration(double duration);
}

@JS('CustomScroll')
external CustomScroll get customScroll; 


// @Import.onWeb('package:portfolio_site/services/interop/scroll_interop.dart', show: [#headerScroll])
// import 'header.imports.dart';

  // String _headerClasses = 'at-top'; // Default classes
  // Timer? _headerUpdateTimer;

  // @override
  // void initState() {
  //   super.initState();
  //   if (kIsWeb) {
  //     _setupHeader();
  //   }
  // }

  // void _setupHeader() {
  //   // Configure header
  //   headerScroll.setThreshold(50);
  //   headerScroll.setSelector('#main-header');
  //   headerScroll.init();

  //   // Start polling for header class updates every 500ms
  //   _startHeaderPolling();
  // }

  // void _startHeaderPolling() {
  //   _headerUpdateTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {
  //     if (!mounted) {
  //       timer.cancel();
  //       return;
  //     }

  //     final newClasses = headerScroll.getHeaderClassName();
  //     if (newClasses != _headerClasses) {
  //       setState(() {
  //         _headerClasses = newClasses;
  //       });
  //     }
  //   });
  // }