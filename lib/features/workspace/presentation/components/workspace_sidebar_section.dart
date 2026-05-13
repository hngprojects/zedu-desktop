import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class WorkspaceSidebarSection extends StatelessWidget {
  const WorkspaceSidebarSection({
    required this.category,
    required this.isCollapsed,
    required this.selectedItemId,
    required this.onToggle,
    required this.onItemSelected,
    super.key,
  });

  final WorkspaceCategory category;
  final bool isCollapsed;
  final String selectedItemId;
  final VoidCallback onToggle;
  final ValueChanged<String> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SectionHeader(
          category: category,
          isCollapsed: isCollapsed,
          onToggle: onToggle,
        ),
        if (!isCollapsed)
          if (category.items.isEmpty)
            const _EmptyCategoryState()
          else
            ...category.items.map(
              (item) => _WorkspaceSidebarItem(
                item: item,
                isSelected: item.id == selectedItemId,
                onTap: () => onItemSelected(item.id),
              ),
            ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.category,
    required this.isCollapsed,
    required this.onToggle,
  });

  final WorkspaceCategory category;
  final bool isCollapsed;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final hasUnread = category.totalUnreadCount > 0;

    return InkWell(
      onTap: onToggle,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 6),
        child: Row(
          children: [
            Icon(
              isCollapsed
                  ? Icons.keyboard_arrow_right_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: Colors.white70,
              size: 18,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                category.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (hasUnread)
              _UnreadBadge(count: category.totalUnreadCount)
            else
              const Icon(
                Icons.more_vert_rounded,
                color: Colors.white38,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}

class _WorkspaceSidebarItem extends StatelessWidget {
  const _WorkspaceSidebarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final WorkspaceItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isChannel = item.type == WorkspaceItemType.channel;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withValues(alpha: 0.18) : null,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        dense: true,
        minLeadingWidth: 20,
        leading: isChannel
            ? const Text(
                '#',
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w800,
                ),
              )
            : const CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 13, color: Color(0xFF7141F8)),
              ),
        title: Text(
          item.name,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
        trailing: item.unreadCount > 0
            ? _UnreadBadge(count: item.unreadCount)
            : null,
        onTap: onTap,
      ),
    );
  }
}

class _UnreadBadge extends StatelessWidget {
  const _UnreadBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 20),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        count > 99 ? '99+' : count.toString(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 10,
        ),
      ),
    );
  }
}

class _EmptyCategoryState extends StatelessWidget {
  const _EmptyCategoryState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 4, 18, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'No items available',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
