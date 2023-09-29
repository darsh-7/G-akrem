import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyItemsScreen extends StatelessWidget {
  const EmptyItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: SvgPicture.asset(AppImages.emptyBoxIcon),
            ),
          ),
          Text(
            'No Items',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          const Text(
            'add items to donate by taping the + button\n\n'
            'If there is any trouble you can click "How it works"',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: FilledButton(
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.lightBlue),
                //TODO: add video
              ),
              onPressed: () {
                //Provider.of<TabManager>(context, listen: false).goToRecipes();
              },
              child: const Text('How it works'),
            ),
          )
        ],
      ),
    );
  }
}
