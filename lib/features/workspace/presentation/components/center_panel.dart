import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class CenterPanel extends ConsumerWidget {
  const CenterPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceState = ref.watch(workspaceProvider);
    final selectedItem = workspaceState.selectedItem;

    if (workspaceState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (workspaceState.errorMessage != null) {
      return _CenterPanelErrorState(
        message: workspaceState.errorMessage!,
        onRetry: () {
          ref.read(workspaceProvider.notifier).retrySelectedItem();
        },
      );
    }

    if (selectedItem == null) {
      return _CenterPanelErrorState(
        message: 'This conversation is no longer available.',
        onRetry: () {
          ref.read(workspaceProvider.notifier).retrySelectedItem();
        },
      );
    }

    return Column(
      children: [
        _CenterPanelHeader(selectedItem: selectedItem),
        Expanded(child: _ConversationEmptyState(selectedItem: selectedItem)),
        _MessageComposer(selectedItem: selectedItem),
      ],
    );
  }
}

class _CenterPanelHeader extends StatelessWidget {
  const _CenterPanelHeader({required this.selectedItem});

  final WorkspaceItem selectedItem;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.light;
    final titlePrefix = selectedItem.type == WorkspaceItemType.channel
        ? '# '
        : '';

    return Container(
      height: 73,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: palette.background,
        border: Border(bottom: BorderSide(color: palette.divider)),
      ),
      child: Row(
        children: [
          Text(
            '$titlePrefix${selectedItem.name}',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: palette.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt_1_outlined, size: 16),
            label: const Text('Invite Your Team'),
          ),
          const SizedBox(width: 8),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
    );
  }
}

class _ConversationEmptyState extends StatelessWidget {
  const _ConversationEmptyState({required this.selectedItem});

  final WorkspaceItem selectedItem;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.light;
    final titlePrefix = selectedItem.type == WorkspaceItemType.channel
        ? '# '
        : '';

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF0E8FF), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: Align(
        alignment: const Alignment(0, -0.45),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 44,
                color: Color(0xFF7141F8),
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to $titlePrefix${selectedItem.name}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Share information, updates, and conversations here.',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: palette.textHint),
              ),
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.group_add_outlined),
                label: const Text('Add members'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageComposer extends StatelessWidget {
  const _MessageComposer({required this.selectedItem});

  final WorkspaceItem selectedItem;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.light;
    final titlePrefix = selectedItem.type == WorkspaceItemType.channel
        ? '#'
        : '';

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
        child: TextField(
          minLines: 1,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Message $titlePrefix${selectedItem.name}',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.borderOutline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.borderOutline),
            ),
          ),
        ),
      ),
    );
  }
}

class _CenterPanelErrorState extends StatelessWidget {
  const _CenterPanelErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.light;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 40, color: palette.error),
            const SizedBox(height: 12),
            Text(
              'Unable to load conversation',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: palette.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: palette.textHint),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
