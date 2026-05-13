import 'package:zedu/core/core.dart';
import 'package:zedu/features/features.dart';

class WorkspaceView extends StatelessWidget {
  const WorkspaceView({super.key});

  static const double _sidebarWidth = 401;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.light.background,
      body: const SafeArea(
        child: Column(
          children: [
            WorkspaceTopBar(),
            Expanded(
              child: Row(
                children: [
                  SizedBox(width: _sidebarWidth, child: WorkspaceSidebar()),
                  Expanded(child: CenterPanel()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
