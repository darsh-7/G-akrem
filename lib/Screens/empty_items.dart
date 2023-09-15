import 'package:akrem/constants/app_images.dart';
import 'package:flutter/material.dart';

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
              child: Image.asset(AppImages.emptyList),
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
          FilledButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.lightBlue),
            ),
            onPressed: () {
              //Provider.of<TabManager>(context, listen: false).goToRecipes();
            },
            child: const Text('How it works'),
          ),
        ],
      ),
    );
  }
}
