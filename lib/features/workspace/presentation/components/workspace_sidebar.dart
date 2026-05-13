import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class WorkspaceSidebar extends ConsumerWidget {
  const WorkspaceSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceState = ref.watch(workspaceProvider);
    final workspaceNotifier = ref.read(workspaceProvider.notifier);

    return Container(
      color: AppPalette.light.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _WorkspaceHeader(),
          const Divider(height: 1, color: Colors.white24),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                const _SidebarTopItem(
                  icon: Icons.forum_outlined,
                  title: 'Threads',
                ),
                const _SidebarTopItem(
                  icon: Icons.dashboard_outlined,
                  title: 'Overview',
                ),
                const SizedBox(height: 12),
                ...workspaceState.categories.map(
                  (category) => WorkspaceSidebarSection(
                    category: category,
                    isCollapsed: workspaceState.isCategoryCollapsed(
                      category.id,
                    ),
                    selectedItemId: workspaceState.selectedItemId,
                    onToggle: () =>
                        workspaceNotifier.toggleCategory(category.id),
                    onItemSelected: workspaceNotifier.selectItem,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceHeader extends StatelessWidget {
  const _WorkspaceHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.workspaces_outline,
              size: 18,
              color: Color(0xFF7141F8),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'HNG Workspace',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _SidebarTopItem extends StatelessWidget {
  const _SidebarTopItem({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 20,
      leading: Icon(icon, size: 18, color: Colors.white70),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
