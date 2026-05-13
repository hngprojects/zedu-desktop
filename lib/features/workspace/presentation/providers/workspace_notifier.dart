import 'package:zedu/core/core.dart';

import 'workspace_state.dart';

class WorkspaceNotifier extends Notifier<WorkspaceState> {
  @override
  WorkspaceState build() {
    return WorkspaceState.initial();
  }

  void toggleCategory(String categoryId) {
    final updatedCollapsedIds = <String>{...state.collapsedCategoryIds};

    if (updatedCollapsedIds.contains(categoryId)) {
      updatedCollapsedIds.remove(categoryId);
    } else {
      updatedCollapsedIds.add(categoryId);
    }

    state = state.copyWith(collapsedCategoryIds: updatedCollapsedIds);
  }

  void selectItem(String itemId) {
    final itemExists = state.categories.any(
      (WorkspaceCategory category) {
        return category.items.any((WorkspaceItem item) => item.id == itemId);
      },
    );

    if (!itemExists) {
      _redirectToDefaultItem();
      return;
    }

    state = state.copyWith(
      selectedItemId: itemId,
      isLoading: false,
      clearError: true,
    );
  }

  void retrySelectedItem() {
    state = state.copyWith(
      isLoading: false,
      clearError: true,
    );
  }

  void _redirectToDefaultItem() {
    final availableItems = state.categories.expand(
      (WorkspaceCategory category) => category.items,
    );

    if (availableItems.isEmpty) return;

    state = state.copyWith(
      selectedItemId: availableItems.first.id,
      clearError: true,
    );
  }
}