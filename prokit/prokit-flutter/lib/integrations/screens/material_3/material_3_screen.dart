import 'package:flutter/material.dart';
import 'package:prokit_flutter/integrations/screens/material_3/constants.dart';
import 'package:prokit_flutter/integrations/screens/material_3/home.dart';
import 'package:prokit_flutter/main.dart';

class Material3Screen extends StatefulWidget {
  static String tag = '/material_3_integration';

  Material3Screen({Key? key}) : super(key: key);

  @override
  State<Material3Screen> createState() => _Material3ScreenState();
}

class _Material3ScreenState extends State<Material3Screen> {
  bool _useMaterial3 = true;
  ThemeMode _themeMode = appStore.isDarkModeOn ? ThemeMode.dark : ThemeMode.light;

  ColorSeed _colorSelected = ColorSeed.baseColor;
  ColorImageProvider _imageSelected = ColorImageProvider.leaves;
  ColorScheme? _imageColorScheme = const ColorScheme.light();
  ColorSelectionMethod _colorSelectionMethod = ColorSelectionMethod.colorSeed;

  bool get _useLightMode => _themeMode == ThemeMode.light;

  void _handleBrightnessChange(bool useLightMode) {
    setState(() {
      _themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
      appStore.toggleDarkMode(value: !useLightMode);
    });
  }

  void _handleMaterialVersionChange() {
    setState(() {
      _useMaterial3 = !_useMaterial3;
    });
  }

  void _handleColorSelect(int value) {
    setState(() {
      _colorSelectionMethod = ColorSelectionMethod.colorSeed;
      _colorSelected = ColorSeed.values[value];
    });
  }

  void _handleImageSelect(int value) {
    final String url = ColorImageProvider.values[value].url;
    ColorScheme.fromImageProvider(provider: NetworkImage(url)).then((
      newScheme,
    ) {
      setState(() {
        _colorSelectionMethod = ColorSelectionMethod.image;
        _imageSelected = ColorImageProvider.values[value];
        _imageColorScheme = newScheme;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorSchemeSeed: _colorSelectionMethod == ColorSelectionMethod.colorSeed ? _colorSelected.color : null,
      colorScheme: _colorSelectionMethod == ColorSelectionMethod.image ? _imageColorScheme : null,
      useMaterial3: _useMaterial3,
      brightness: Brightness.light,
    );

    final darkTheme = ThemeData(
      colorSchemeSeed: _colorSelectionMethod == ColorSelectionMethod.colorSeed ? _colorSelected.color : _imageColorScheme!.primary,
      useMaterial3: _useMaterial3,
      brightness: Brightness.dark,
    );

    return Theme(
      data: _useLightMode ? theme : darkTheme,
      child: Home(
        useLightMode: _useLightMode,
        useMaterial3: _useMaterial3,
        colorSelected: _colorSelected,
        imageSelected: _imageSelected,
        handleBrightnessChange: _handleBrightnessChange,
        handleMaterialVersionChange: _handleMaterialVersionChange,
        handleColorSelect: _handleColorSelect,
        handleImageSelect: _handleImageSelect,
        colorSelectionMethod: _colorSelectionMethod,
      ),
    );
  }
}
