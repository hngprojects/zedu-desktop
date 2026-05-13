import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  static const double _sidebarWidth = 360;
  static const double _rightPanelWidth = 320;
  static const double _panelGap = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.light.background,
      body: SafeArea(
        child: Row(
          children: const [
            SizedBox(
              width: _sidebarWidth,
              child: WorkspaceSidebar(),
            ),
            SizedBox(width: _panelGap),
            Expanded(
              child: CenterPanel(),
            ),
            SizedBox(width: _panelGap),
            SizedBox(
              width: _rightPanelWidth,
              child: RightContextPanel(),
            ),
          ],
        ),
      ),
    );
  }
}
