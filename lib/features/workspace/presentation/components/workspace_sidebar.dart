import 'package:zedu/core/core.dart';

class WorkspaceSidebar extends StatelessWidget {
  const WorkspaceSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.light;

    return Container(
      color: palette.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WorkspaceHeader(palette: palette),
          const Divider(height: 1, color: Colors.white24),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: const [
                _SidebarItem(
                  icon: Icons.forum_outlined,
                  title: 'Threads',
                ),
                _SidebarItem(
                  icon: Icons.dashboard_outlined,
                  title: 'Overview',
                ),
                SizedBox(height: 16),
                _SidebarSectionTitle(title: 'Channels'),
                _SidebarChannelItem(
                  title: 'all-my-mail',
                  unreadCount: 0,
                  isSelected: false,
                ),
                _SidebarChannelItem(
                  title: 'general',
                  unreadCount: 0,
                  isSelected: true,
                ),
                SizedBox(height: 16),
                _SidebarSectionTitle(title: 'Agents'),
                _SidebarUserItem(name: 'Arlo - Mail Sender'),
                _SidebarUserItem(name: 'Ruby - Social Media Handler'),
                _SidebarUserItem(name: 'Mia - Seo Tracker'),
                _SidebarUserItem(name: 'Finn - Sales Tracker'),
                _SidebarUserItem(name: 'Leo - Ad Performance Tracker'),
                SizedBox(height: 16),
                _SidebarSectionTitle(title: 'Direct Messages'),
                _SidebarUserItem(name: 'Tunde Orji'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkspaceHeader extends StatelessWidget {
  const _WorkspaceHeader({required this.palette});

  final AppPalette palette;

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

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.title,
  });

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
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

class _SidebarSectionTitle extends StatelessWidget {
  const _SidebarSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 8, 18, 6),
      child: Row(
        children: [
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white60,
            size: 16,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Icon(
            Icons.more_vert_rounded,
            color: Colors.white38,
            size: 16,
          ),
        ],
      ),
    );
  }
}

class _SidebarChannelItem extends StatelessWidget {
  const _SidebarChannelItem({
    required this.title,
    required this.unreadCount,
    required this.isSelected,
  });

  final String title;
  final int unreadCount;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withValues(alpha: 0.18) : null,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        dense: true,
        minLeadingWidth: 18,
        leading: const Text(
          '#',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w700,
          ),
        ),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
        ),
        trailing: unreadCount > 0
            ? CircleAvatar(
                radius: 10,
                backgroundColor: Colors.red,
                child: Text(
                  unreadCount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}

class _SidebarUserItem extends StatelessWidget {
  const _SidebarUserItem({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 20,
      leading: const CircleAvatar(
        radius: 10,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.person,
          size: 13,
          color: Color(0xFF7141F8),
        ),
      ),
      title: Text(
        name,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
} 