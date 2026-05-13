import 'package:zedu/core/core.dart';

class WorkspaceTopBar extends StatelessWidget {
  const WorkspaceTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      color: const Color(0xFF302F84),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          SizedBox(
            width: 380,
            child: Row(
              children: [
                _WorkspaceSwitcherButton(),
                const SizedBox(width: 12),
                const _WorkspaceAvatar(initials: 'TC', unreadCount: 15),
                const SizedBox(width: 8),
                const _WorkspaceAvatar(initials: 'AD', unreadCount: 23),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back_rounded),
            color: Colors.white54,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_rounded),
            color: Colors.white54,
          ),
          const SizedBox(width: 12),
          const SizedBox(width: 301, child: _SearchBox()),
          const Spacer(),
          const _CreditsPill(),
        ],
      ),
    );
  }
}

class _WorkspaceSwitcherButton extends StatelessWidget {
  const _WorkspaceSwitcherButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.workspaces_outline,
              size: 15,
              color: Color(0xFF3F3D97),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'HNG Workspace',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
            size: 18,
          ),
        ],
      ),
    );
  }
}

class _WorkspaceAvatar extends StatelessWidget {
  const _WorkspaceAvatar({required this.initials, required this.unreadCount});

  final String initials;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9B55),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Text(
            initials,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Positioned(
          right: -5,
          top: -5,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              color: const Color(0xFFFF3B30),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0xFF302F84), width: 1.5),
            ),
            child: Text(
              unreadCount.toString(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(
            'Search Files',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreditsPill extends StatelessWidget {
  const _CreditsPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.credit_card_rounded,
            size: 14,
            color: Color(0xFF3F3D97),
          ),
          const SizedBox(width: 6),
          Text(
            '483 AI Credits',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: const Color(0xFF3F3D97),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
