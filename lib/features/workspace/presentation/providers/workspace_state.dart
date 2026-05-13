import 'package:zedu/core/core.dart';

enum WorkspaceItemType { channel, agent, directMessage }

@immutable
class WorkspaceItem {
  const WorkspaceItem({
    required this.id,
    required this.name,
    required this.type,
    this.unreadCount = 0,
  });

  final String id;
  final String name;
  final WorkspaceItemType type;
  final int unreadCount;
}

@immutable
class WorkspaceCategory {
  const WorkspaceCategory({
    required this.id,
    required this.title,
    required this.items,
  });

  final String id;
  final String title;
  final List<WorkspaceItem> items;

  int get totalUnreadCount {
    return items.fold<int>(0, (total, item) => total + item.unreadCount);
  }
}

@immutable
class WorkspaceState {
  const WorkspaceState({
    required this.categories,
    required this.collapsedCategoryIds,
    required this.selectedItemId,
    this.isLoading = false,
    this.errorMessage,
  });

  factory WorkspaceState.initial() {
    const categories = [
      WorkspaceCategory(
        id: 'channels',
        title: 'Channels',
        items: [
          WorkspaceItem(
            id: 'all-my-mail',
            name: 'all-my-mail',
            type: WorkspaceItemType.channel,
          ),
          WorkspaceItem(
            id: 'general',
            name: 'general',
            type: WorkspaceItemType.channel,
            unreadCount: 3,
          ),
        ],
      ),
      WorkspaceCategory(
        id: 'agents',
        title: 'Agents',
        items: [
          WorkspaceItem(
            id: 'arlo-mail-sender',
            name: 'Arlo - Mail Sender',
            type: WorkspaceItemType.agent,
          ),
          WorkspaceItem(
            id: 'ruby-social-media-handler',
            name: 'Ruby - Social Media Handler',
            type: WorkspaceItemType.agent,
            unreadCount: 2,
          ),
          WorkspaceItem(
            id: 'mia-seo-tracker',
            name: 'Mia - Seo Tracker',
            type: WorkspaceItemType.agent,
          ),
          WorkspaceItem(
            id: 'finn-sales-tracker',
            name: 'Finn - Sales Tracker',
            type: WorkspaceItemType.agent,
          ),
          WorkspaceItem(
            id: 'leo-ad-performance-tracker',
            name: 'Leo - Ad Performance Tracker',
            type: WorkspaceItemType.agent,
          ),
        ],
      ),
      WorkspaceCategory(
        id: 'direct-messages',
        title: 'Direct Messages',
        items: [
          WorkspaceItem(
            id: 'tunde-orji',
            name: 'Tunde Orji',
            type: WorkspaceItemType.directMessage,
          ),
        ],
      ),
    ];

    return WorkspaceState(
      categories: categories,
      collapsedCategoryIds: {},
      selectedItemId: 'general',
    );
  }

  final List<WorkspaceCategory> categories;
  final Set<String> collapsedCategoryIds;
  final String selectedItemId;
  final bool isLoading;
  final String? errorMessage;

  WorkspaceItem? get selectedItem {
    for (final category in categories) {
      for (final item in category.items) {
        if (item.id == selectedItemId) return item;
      }
    }

    return null;
  }

  bool isCategoryCollapsed(String categoryId) {
    return collapsedCategoryIds.contains(categoryId);
  }

  WorkspaceState copyWith({
    List<WorkspaceCategory>? categories,
    Set<String>? collapsedCategoryIds,
    String? selectedItemId,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return WorkspaceState(
      categories: categories ?? this.categories,
      collapsedCategoryIds: collapsedCategoryIds ?? this.collapsedCategoryIds,
      selectedItemId: selectedItemId ?? this.selectedItemId,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
