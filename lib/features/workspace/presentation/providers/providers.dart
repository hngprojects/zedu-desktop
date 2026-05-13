import 'package:zedu/core/core.dart';

import 'workspace_notifier.dart';
import 'workspace_state.dart';

export 'workspace_notifier.dart';
export 'workspace_state.dart';

final workspaceProvider = NotifierProvider<WorkspaceNotifier, WorkspaceState>(
  WorkspaceNotifier.new,
);
