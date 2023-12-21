
// ThemeData alahliTheme = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.light,
//   colorScheme: ColorScheme.light(
//     onPrimary: AlahliColor.onPrimatyColor,
//     primary: AlahliColor.primaryColor,
//     primaryContainer: AlahliColor.primaryContainer,
//     onPrimaryContainer: AlahliColor.onPrimatyContainer,
//     secondaryContainer: AlahliColor.secoundaryContainer,
//     error: const Color(0xffBA1A1A),
//     tertiary: const Color(0xff466179),
//     onTertiary: const Color(0xffFFFFFF),
//     tertiaryContainer: const Color(0xffCCE5FF),
//     onTertiaryContainer: const Color(0xff001D31),
//     background: const Color(0xffFAFDFB),
//     onBackground: const Color(0xff191C1B),
//     brightness: Brightness.light,
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//         foregroundColor: AlNasserColor.onPrimaryColor, 
//         backgroundColor: AlNasserColor.appBarColor, // text color
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//       ),
//   ),
//   fontFamilyFallback: [
//     MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal'
//   ],
//   fontFamily:
//       MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal',
//   primaryColor: AlahliColor.primaryColor,
//   expansionTileTheme: ExpansionTileThemeData(
//       childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
//       collapsedShape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       collapsedBackgroundColor: AlahliColor.secoundaryContainer,
//       backgroundColor: AlahliColor.secoundaryContainer,
//       textColor: AlahliColor.onPrimatyContainer),
//   scaffoldBackgroundColor: const Color(0xffFAFDFA),
//   secondaryHeaderColor: const Color(0xff605C71),
//   primaryColorLight: AlahliColor.onPrimatyColor,
//   disabledColor: const Color(0xff9D9D9E),
//   dividerColor: const Color.fromARGB(255, 199, 204, 209),
//   hintColor: const Color(0xFF9F9F9F),
//   dividerTheme: const DividerThemeData(
//     color: Color.fromARGB(255, 184, 194, 191),
//     indent: 20,
//     endIndent: 20,
//   ),
//   appBarTheme: AppBarTheme(
//     titleTextStyle: TextStyle(
//         color: AlahliColor.onPrimatyColor,
//         fontSize: 20,
//         fontWeight: FontWeight.w600),
//     backgroundColor: AlahliColor.primaryColor,
//     scrolledUnderElevation: 0,
//   ),
//   listTileTheme: ListTileThemeData(
//     tileColor:AlahliColor.listTile ,
//     iconColor: AlahliColor.onPrimatyContainer,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     leadingAndTrailingTextStyle: TextStyle(
//       color: AlahliColor.onPrimatyContainer,
//       fontFamily: 'Roboto',
//     ),
//   ),
//   //
//   tabBarTheme: TabBarTheme(
//     indicatorColor: AlahliColor.primaryContainer,
//     labelStyle: TextStyle(
//         color: ColorTealDark.primaryColor,
//         fontSize: 20,
//         fontWeight: FontWeight.w600),
//   ),
//   //
//   textTheme: CustomTextTheme().getTextTheme(),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     elevation: 8,
//     selectedItemColor: AlahliColor.onPrimatyContainer,
//     unselectedItemColor: const Color(0xff9D9D9E),
//     // Unselected icon color
//     backgroundColor: Colors.white,
//     selectedLabelStyle: const TextStyle(
//       color: Colors.white,
//     ),
//     showUnselectedLabels: true,
//   ),
//   textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(foregroundColor: AlahliColor.primaryColor)),
//   dialogTheme:
//       DialogTheme(titleTextStyle: CustomTextTheme().getTextTheme().bodyLarge),
//   dropdownMenuTheme: const DropdownMenuThemeData(
//     textStyle: TextStyle(
//       color: Colors.red,
//       fontFamily: 'Roboto_regular',
//       fontFamilyFallback: ['Roboto'],
//       fontSize: 10,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 1.5,
//       textBaseline: TextBaseline.alphabetic,
//     ),
//   ),
//   //
//   canvasColor: Colors.white,
//   buttonTheme: ButtonThemeData(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       buttonColor: AlahliColor.primaryColor,
//       textTheme: ButtonTextTheme.normal,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20))),
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
//   //
//   cardColor: AlahliColor.cardColor,
//   cardTheme: CardTheme(
//     color: AlahliColor.cardColor,
//     elevation: 1,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//   ),
//   //
// );

// ThemeData dark = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.dark,
//   colorScheme: ColorScheme.dark(
//     onPrimary: ColorTealDark.onPrimaryColor,
//     primary: ColorTealDark.primaryColor,
//     primaryContainer: ColorTealDark.primaryContainer,
//     onPrimaryContainer: ColorTealDark.onPrimaryContainer,
//     error: ColorTealDark.error,
//     onError: ColorTealDark.onError,
//     secondaryContainer: AlahliColor.secoundaryContainer,
//     errorContainer: ColorTealDark.errorContainer,
//     tertiary: ColorTealDark.tertiary,
//     onTertiary: ColorTealDark.onTertiary,
//     tertiaryContainer: ColorTealDark.tertiaryContainer,
//     onTertiaryContainer: ColorTealDark.onTertiaryContainer,
//     background: const Color(0xFF191C1E),
//     onBackground: const Color(0xffE0E3E1),
//     brightness: Brightness.dark,
//   ),
//   fontFamilyFallback: [
//     MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal'
//   ],
//   fontFamily:
//       MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal',
//   primaryColor: ColorTealDark.primaryColor,
//   expansionTileTheme: ExpansionTileThemeData(
//       childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
//       collapsedShape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       collapsedBackgroundColor: ColorTealDark.secoundaryContainer,
//       backgroundColor: ColorTealDark.primaryContainer,
//       textColor: ColorTealDark.onPrimaryContainer),
//   secondaryHeaderColor: const Color(0xff605C71),
//   primaryColorLight: ColorTealDark.onPrimaryColor,
//   disabledColor: const Color(0xff9D9D9E),
//   dividerColor: const Color.fromARGB(255, 199, 204, 209),
//   hintColor: const Color(0xFF9F9F9F),
//   dividerTheme: const DividerThemeData(
//     color: Color(0xff3F4947),
//     indent: 20,
//     endIndent: 20,
//   ),
//   appBarTheme: AppBarTheme(
//     titleTextStyle: TextStyle(
//         color: ColorTealDark.primaryColor,
//         fontSize: 20,
//         fontWeight: FontWeight.w600),
//     backgroundColor: const Color(0xFF191C1E),
//     scrolledUnderElevation: 0,
//     surfaceTintColor: const Color(0xFF191C1E),
//     elevation: 0,
//   ),
//   listTileTheme: ListTileThemeData(
//     iconColor: ColorTealDark.onPrimaryContainer,
//     shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     leadingAndTrailingTextStyle: TextStyle(
//       color: ColorTealDark.onPrimaryContainer,
//       fontFamily: 'IBMPlexSans-Medium',
//     ),
//   ),
//   //
//   dialogTheme: DialogTheme(
//       titleTextStyle: CustomTextTheme().getDarkTextTheme().bodyLarge),
//   //
//   dropdownMenuTheme: const DropdownMenuThemeData(
//     textStyle: TextStyle(
//       color: Colors.red,
//       fontFamily: 'Roboto_regular',
//       fontFamilyFallback: ['Roboto'],
//       fontSize: 10,
//       fontWeight: FontWeight.w400,
//       letterSpacing: 1.5,
//       textBaseline: TextBaseline.alphabetic,
//     ),
//   ),
//   tabBarTheme: TabBarTheme(
//     labelStyle: TextStyle(
//         color: ColorTealDark.primaryColor,
//         fontSize: 20,
//         fontWeight: FontWeight.w600),
//     indicatorColor: ColorTealDark.primaryColor,
//   ),
//   //
//   textTheme: CustomTextTheme().getDarkTextTheme(),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     elevation: 0,
//     selectedItemColor: ColorTealDark.onPrimaryContainer,
//     unselectedItemColor: const Color(0xff9D9D9E),
//     // Unselected icon color
//     backgroundColor: const Color(0xFF191C1E),
//     selectedLabelStyle: const TextStyle(
//       color: Colors.white,
//     ),
//     showUnselectedLabels: true,
//   ),

//   textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(foregroundColor: ColorTealDark.primaryColor)),
//   buttonTheme: ButtonThemeData(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       buttonColor: ColorTealDark.primaryColor,
//       textTheme: ButtonTextTheme.normal,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20))),
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
//   //
//   cardColor: ColorTealDark.primaryContainer,
//   cardTheme: CardTheme(
//     color: ColorTealDark.onPrimaryColor,
//     elevation: 5,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//     ),
//   ),
//   //
// );

// ThemeData alhilalTheme = ThemeData(
//   useMaterial3: true,
//   brightness: Brightness.light,
//   colorScheme: ColorScheme.light(
//     onPrimary: AlHilalColor.onPrimaryColor,
//     secondary: AlHilalColor.appBarColor,
//     primary: AlHilalColor.primaryColor,
//     primaryContainer: AlHilalColor.primaryContainer,
//     onPrimaryContainer: AlHilalColor.onPrimaryContainer,
//     error: const Color(0xffBA1A1A),
//     onError: Colors.white,
//     errorContainer: const Color(0xffFFDAD6),
//     background: AlHilalColor.background,
//     onBackground: AlHilalColor.onBackground,
//     onSurface: AlHilalColor.onSurface,
//     brightness: Brightness.light,
//   ),
//   fontFamily: 'Roboto',
//   primaryColor: AlHilalColor.primaryColor,
//   secondaryHeaderColor: const Color(0xff605C71),
//   primaryColorLight: AlHilalColor.onPrimaryColor,
//   disabledColor: const Color(0xff9D9D9E),
//   dividerColor: const Color.fromARGB(255, 199, 204, 209),
//   hintColor: const Color(0xFF9F9F9F),
//   dividerTheme: const DividerThemeData(
//     color: Color.fromARGB(255, 184, 194, 191),
//     indent: 20,
//     endIndent: 20,
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//         foregroundColor: AlHilalColor.onPrimaryColor, 
//         backgroundColor: AlHilalColor.appBarColor, // text color
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//       ),
//   ),
//   appBarTheme: AppBarTheme(
//     centerTitle: true,
//     titleTextStyle: const TextStyle(
//         color: Color(0xffC3C7CF), fontSize: 20, fontWeight: FontWeight.w600),
//     backgroundColor: AlHilalColor.appBarColor,
//     scrolledUnderElevation: 0,
//     surfaceTintColor: const Color(0xff24292F),
//     elevation: 0,
//   ),
//   iconTheme: IconThemeData(
//     color: AlHilalColor.onPrimaryColor,
//   ),
//   listTileTheme: ListTileThemeData(
//     tileColor: AlHilalColor.listTile,
//     textColor: AlHilalColor.onPrimaryColor,
//     iconColor: AlHilalColor.onPrimaryContainer,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//     leadingAndTrailingTextStyle: TextStyle(
//       color: AlHilalColor.onSurface,
//       fontFamily: 'Roboto',
//     ),
//   ),

//   //
//   tabBarTheme: TabBarTheme(
//     labelStyle: TextStyle(
//         color: AlHilalColor.primaryColor,
//         fontSize: 20,
//         fontWeight: FontWeight.w600),
//     indicatorColor: AlHilalColor.onPrimaryColor,
//   ),
//   //
//   textTheme: CustomTextTheme().getTextTheme(),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     elevation: 0,
//     selectedItemColor: AlHilalColor.appBarColor,
//     unselectedItemColor: const Color(0xff9D9D9E),
//     // Unselected icon color
//     backgroundColor: const Color(0xff1D2A28),
//     selectedLabelStyle: const TextStyle(
//       color: Colors.white,
//     ),
//     showUnselectedLabels: true,
//   ),

//   textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(foregroundColor: AlHilalColor.primaryColor)),
//   buttonTheme: ButtonThemeData(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       buttonColor: AlHilalColor.primaryColor,
//       textTheme: ButtonTextTheme.normal,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(20))),
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
//   //
//   cardColor: AlHilalColor.cardColor,
//   cardTheme: CardTheme(
//     color: AlHilalColor.cardColor,
//     elevation: 1,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//   ),
//   //
// );

// ThemeData alNasserTheme = ThemeData(
//   scaffoldBackgroundColor: AlNasserColor.background,
//   useMaterial3: true,
//   brightness: Brightness.light,
//   colorScheme: ColorScheme.light(
//     onPrimary: AlNasserColor.onPrimaryColor,
//     secondary: AlNasserColor.appBarColor,
//     primary: AlNasserColor.primaryColor,
//     error: const Color(0xffBA1A1A),
//     onError: Colors.white,
//     background: AlNasserColor.background,
//     onBackground: AlNasserColor.onBackground,
//     brightness: Brightness.light,
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//         foregroundColor: AlNasserColor.onPrimaryColor, 
//         backgroundColor: AlNasserColor.appBarColor, // text color
//         elevation: 0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
//       ),
//   ),
//   fontFamilyFallback: [
//     MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal'
//   ],
//   fontFamily:
//       MyLocalController().selectedLang.value == 'en' ? 'Roboto' : 'Tajawal',
//   expansionTileTheme: ExpansionTileThemeData(
//       childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
//       collapsedShape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       collapsedBackgroundColor: AlahliColor.secoundaryContainer,
//       backgroundColor: AlahliColor.secoundaryContainer,
//       textColor: AlahliColor.onPrimatyContainer),
//   primaryColor: AlNasserColor.primaryColor,
//   primaryColorLight: AlNasserColor.onPrimaryColor,
//   dividerTheme: const DividerThemeData(
//     indent: 20,
//     endIndent: 20,
//   ),
//   appBarTheme: AppBarTheme(
//     centerTitle: true,
//     backgroundColor: AlNasserColor.appBarColor,
//     scrolledUnderElevation: 0,
//     surfaceTintColor: const Color(0xff24292F),
//     elevation: 0,
//   ),
//   iconTheme: IconThemeData(
//     color: AlNasserColor.primaryColor,
//   ),
//   listTileTheme: ListTileThemeData(
//     tileColor: AlNasserColor.listTile,
//     iconColor: AlNasserColor.onPrimaryColor,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//     leadingAndTrailingTextStyle: TextStyle(
//       color: AlNasserColor.onPrimaryColor,
//       fontFamily: 'Roboto',
//     ),
//   ),
//   tabBarTheme: TabBarTheme(
//     labelStyle: TextStyle(
//         color: AlNasserColor.primaryColor,
//         fontSize: 20,
//         fontWeight: FontWeight.w600),
//     indicatorColor: AlNasserColor.onPrimaryColor,
//   ),
//   textTheme: CustomTextTheme().getTextTheme(),
//   bottomNavigationBarTheme: BottomNavigationBarThemeData(
//     elevation: 5,
//     enableFeedback: true,
//     selectedItemColor: AlNasserColor.primaryColor,
//     unselectedItemColor: const Color(0xff9D9D9E),
//     backgroundColor: AlNasserColor.onPrimaryColor,
//     selectedLabelStyle: TextStyle(
//       color: AlNasserColor.primaryColor,
//     ),
//     showUnselectedLabels: true,
//   ),
//   textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(foregroundColor: AlNasserColor.primaryColor)),
//   buttonTheme: ButtonThemeData(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//       buttonColor: AlNasserColor.primaryColor,
//       textTheme: ButtonTextTheme.normal,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(8))),
//       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
//   cardColor: AlNasserColor.cardColor,
//   cardTheme: CardTheme(
//     color: AlNasserColor.cardColor,
//     elevation: 1,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//   ),
// );
