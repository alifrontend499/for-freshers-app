import 'package:flutter/material.dart';

// -- settings | global
import 'package:app/global/settings/global_settings.dart';

// -- colors | global
import 'package:app/global/colors/global_colors.dart';

class PremiumTestDialog extends StatelessWidget {
  const PremiumTestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(20),
      children: [
        // child | heading
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.lock,
              size: 20,
              color: Colors.black,
            ),
            SizedBox(width: 10),
            Text(
              'Premium Test',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // child | description
        const Text(
          'A premium account is required to access this test',
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 20),

        // child | button
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size(
              double.infinity,
              globalSettingsDefaultButtonHeight,
            ),
            backgroundColor: globalColorAppPrimary,
            splashFactory: NoSplash.splashFactory,
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: const Text('Get Premium'),
        ),

        const SizedBox(height: 15),

        Column(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              highlightColor: globalColorInkWellHighlight,
              borderRadius: BorderRadius.circular(5),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Text(
                  'Continue Without Premium',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: globalColorAppPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
