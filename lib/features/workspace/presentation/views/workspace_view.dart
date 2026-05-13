import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  static const double _sidebarWidth = 280;
  static const double _rightPanelWidth = 320;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.light.background,
      body: SafeArea(
        child: Row(
          children: const [
            SizedBox(width: _sidebarWidth, child: WorkspaceSidebar()),
            VerticalDivider(width: 1, thickness: 1),
            Expanded(child: CenterPanel()),
            VerticalDivider(width: 1, thickness: 1),
            SizedBox(width: _rightPanelWidth, child: RightContextPanel()),
          ],
        ),
      ),
    );
  }
}
