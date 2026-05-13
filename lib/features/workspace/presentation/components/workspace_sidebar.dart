import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class WorkspaceSidebar extends ConsumerWidget {
  const WorkspaceSidebar({super.key});

  static const double _iconRailWidth = 61;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceState = ref.watch(workspaceProvider);
    final workspaceNotifier = ref.read(workspaceProvider.notifier);

    return Row(
      children: [
        const _SidebarIconRail(),
        Expanded(
          child: Container(
            color: const Color(0xFF3F3D97),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                const _SidebarHeader(),
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
        ),
      ],
    );
  }
}

class _SidebarIconRail extends StatelessWidget {
  const _SidebarIconRail();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WorkspaceSidebar._iconRailWidth,
      decoration: BoxDecoration(
        color: const Color(0xFF34318B),
        border: Border(
          right: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
      ),
      child: const Column(
        children: [
          SizedBox(height: 10),
          _RailItem(icon: Icons.home_rounded, label: 'Home', isActive: true),
          _RailItem(icon: Icons.chat_bubble_outline_rounded, label: 'DMs'),
          _RailItem(icon: Icons.person_outline_rounded, label: 'People'),
          _RailItem(icon: Icons.android_outlined, label: 'Agents'),
          _RailItem(icon: Icons.insert_drive_file_outlined, label: 'Files'),
          SizedBox(height: 16),
          Spacer(),
          _RailItem(icon: Icons.hub_outlined, label: ''),
          _RailItem(
            icon: Icons.notifications_none_rounded,
            label: '',
            showNotification: true,
          ),
          _RailItem(icon: Icons.settings_outlined, label: ''),
          SizedBox(height: 10),
          _ProfileAvatar(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _SidebarHeader extends StatelessWidget {
  const _SidebarHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Home',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit_outlined),
              color: Colors.white70,
              iconSize: 18,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RailItem extends StatelessWidget {
  const _RailItem({
    required this.icon,
    required this.label,
    this.isActive = false,
    this.showNotification = false,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final bool showNotification;

  @override
  Widget build(BuildContext context) {
    final hasLabel = label.isNotEmpty;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isActive)
            Positioned(
              left: 0,
              child: Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          Container(
            width: 48,
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            padding: EdgeInsets.symmetric(vertical: hasLabel ? 6 : 8),
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white.withValues(alpha: 0.10)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: Colors.white),
                if (hasLabel) ...[
                  const SizedBox(height: 3),
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showNotification)
            Positioned(
              right: 10,
              top: 5,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    color: const Color(0xFF34318B),
                    width: 1.5,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Text(
              'AP',
              style: TextStyle(
                color: Color(0xFF34318B),
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF34318B), width: 2),
            ),
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
      leading: Icon(icon, size: 16, color: Colors.white70),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
