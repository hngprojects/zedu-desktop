import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authNotifierProvider);

    if (auth.status == AuthStatus.unknown) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Zedu'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: auth.isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : TextButton(
                      onPressed: () =>
                          ref.read(authNotifierProvider.notifier).logout(),
                      child: const Text('Log out'),
                    ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          auth.user != null ? 'Signed in as ${auth.user!.email}' : 'Home',
        ),
      ),
    );
  }
}
