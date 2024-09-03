import 'package:flutter/material.dart';
import '../../main.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: 119,
        height: 56,
        child: GestureDetector(
          onTap: () {
            final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
            final RenderBox button = context.findRenderObject() as RenderBox;
            final RelativeRect position = RelativeRect.fromRect(
              Rect.fromPoints(
                button.localToGlobal(Offset.zero, ancestor: overlay),
                button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
              ),
              Offset.zero & overlay.size,
            );

            showMenu<String>(
              context: context,
              position: position,
              items: localSettingsController.languages.map((String language) {
                return PopupMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ).then((String? value) {
              if (value != null) {
                localSettingsController.changeLanguage(value);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.language, color: Colors.red),
                SizedBox(width: 8),
                Text(localSettingsController.selectLanguage.value),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      );
    });
  }
}