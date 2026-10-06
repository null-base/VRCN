import AppIntents
import SwiftUI
import WidgetKit

private let widgetKind = "FriendStatusWidget"
private let appGroupId = "group.com.null-base.vrchat"
private let storageKey = "friendStatusWidgetFriends"
private let allFriendsStorageKey = "friendStatusWidgetAllFriends"

private enum FriendStatusStore {
  static func loadFriends(forKey key: String) -> [FriendStatus] {
    guard
      let payload = UserDefaults(suiteName: appGroupId)?.string(forKey: key),
      let data = payload.data(using: .utf8),
      let friends = try? JSONDecoder().decode([FriendStatus].self, from: data)
    else {
      return []
    }

    return friends
  }
}

struct FriendStatusEntry: TimelineEntry {
  let date: Date
  let friends: [FriendStatus]
  let selectedFriendUnavailable: Bool

  init(date: Date, friends: [FriendStatus], selectedFriendUnavailable: Bool = false) {
    self.date = date
    self.friends = friends
    self.selectedFriendUnavailable = selectedFriendUnavailable
  }
}

struct FriendStatus: Decodable, Identifiable {
  let id: String
  let name: String
  let status: String
  let statusLabel: String
  let location: String
  let isOnline: Bool?
  let updatedAt: String

  var isCurrentlyOnline: Bool {
    isOnline ?? (status != "offline")
  }

  var displayStatusLabel: String {
    isCurrentlyOnline ? statusLabel : String(localized: "widget_status_offline")
  }

  var color: Color {
    guard isCurrentlyOnline else { return .gray }

    switch status {
    case "joinMe":
      return .blue
    case "askMe":
      return .orange
    case "busy":
      return .red
    default:
      return .green
    }
  }
}

struct LegacyFriendStatusProvider: TimelineProvider {
  func placeholder(in context: Context) -> FriendStatusEntry {
    FriendStatusEntry(date: .now, friends: [])
  }

  func getSnapshot(
    in context: Context,
    completion: @escaping (FriendStatusEntry) -> Void
  ) {
    completion(FriendStatusEntry(date: .now, friends: FriendStatusStore.loadFriends(forKey: storageKey)))
  }

  func getTimeline(
    in context: Context,
    completion: @escaping (Timeline<FriendStatusEntry>) -> Void
  ) {
    let entry = FriendStatusEntry(date: .now, friends: FriendStatusStore.loadFriends(forKey: storageKey))
    completion(Timeline(entries: [entry], policy: .after(.now.addingTimeInterval(15 * 60))))
  }
}

@available(iOSApplicationExtension 17.0, *)
struct WidgetFriend: AppEntity {
  let id: String
  let name: String

  static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "widget_friend")
  static var defaultQuery = WidgetFriendQuery()

  var displayRepresentation: DisplayRepresentation {
    DisplayRepresentation(title: "\(name)")
  }
}

@available(iOSApplicationExtension 17.0, *)
struct WidgetFriendQuery: EntityStringQuery {
  func entities(for identifiers: [String]) async throws -> [WidgetFriend] {
    let ids = Set(identifiers)
    return availableFriends().filter { ids.contains($0.id) }
  }

  func suggestedEntities() async throws -> [WidgetFriend] {
    availableFriends()
  }

  func entities(matching string: String) async throws -> [WidgetFriend] {
    availableFriends().filter { $0.name.localizedCaseInsensitiveContains(string) }
  }

  private func availableFriends() -> [WidgetFriend] {
    FriendStatusStore.loadFriends(forKey: allFriendsStorageKey)
      .map { WidgetFriend(id: $0.id, name: $0.name) }
      .sorted { $0.name.localizedStandardCompare($1.name) == .orderedAscending }
  }
}

@available(iOSApplicationExtension 17.0, *)
struct FriendStatusConfiguration: WidgetConfigurationIntent {
  static var title: LocalizedStringResource = "widget_name"

  @Parameter(title: "widget_friend")
  var friend: WidgetFriend?

  init() {}
}

@available(iOSApplicationExtension 17.0, *)
struct ConfigurableFriendStatusProvider: AppIntentTimelineProvider {
  func placeholder(in context: Context) -> FriendStatusEntry {
    FriendStatusEntry(date: .now, friends: [])
  }

  func snapshot(for configuration: FriendStatusConfiguration, in context: Context) async -> FriendStatusEntry {
    entry(for: configuration)
  }

  func timeline(for configuration: FriendStatusConfiguration, in context: Context) async -> Timeline<FriendStatusEntry> {
    Timeline(entries: [entry(for: configuration)], policy: .after(.now.addingTimeInterval(15 * 60)))
  }

  private func entry(for configuration: FriendStatusConfiguration) -> FriendStatusEntry {
    guard let friendId = configuration.friend?.id else {
      return FriendStatusEntry(date: .now, friends: FriendStatusStore.loadFriends(forKey: storageKey))
    }

    let selected = FriendStatusStore.loadFriends(forKey: allFriendsStorageKey)
      .first { $0.id == friendId }
    return FriendStatusEntry(
      date: .now,
      friends: selected.map { [$0] } ?? [],
      selectedFriendUnavailable: selected == nil
    )
  }
}

struct FriendStatusWidgetView: View {
  @Environment(\.widgetFamily) private var family
  let entry: FriendStatusEntry

  var body: some View {
    if #available(iOSApplicationExtension 17.0, *) {
      content
        .containerBackground(.background, for: .widget)
    } else {
      content
        .padding()
        .background(Color(.systemBackground))
    }
  }

  private var content: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("VRCN")
        .font(.headline)

      if entry.friends.isEmpty {
        Spacer()
        if entry.selectedFriendUnavailable {
          Text("widget_friend_unavailable")
            .font(.caption)
            .foregroundStyle(.secondary)
        } else if #available(iOSApplicationExtension 17.0, *) {
          Text("widget_empty_edit")
            .font(.caption)
            .foregroundStyle(.secondary)
        } else {
          Text("widget_empty")
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        Spacer()
      } else {
        ForEach(entry.friends.prefix(family == .systemSmall ? 2 : 4)) { friend in
          HStack(spacing: 6) {
            Circle()
              .fill(friend.color)
              .frame(width: 8, height: 8)
            Text(friend.name)
              .lineLimit(1)
              .font(.caption.weight(.semibold))
            Spacer(minLength: 4)
            Text(friend.displayStatusLabel)
              .lineLimit(1)
              .font(.caption2)
              .foregroundStyle(.secondary)
          }
        }
        Spacer(minLength: 0)
        Text(updatedLabel)
          .font(.caption2)
          .foregroundStyle(.tertiary)
      }
    }
  }

  private var updatedLabel: String {
    guard
      let firstUpdatedAt = entry.friends.first?.updatedAt,
      let date = ISO8601DateFormatter().date(from: firstUpdatedAt)
    else {
      return String(localized: "widget_updated_unknown")
    }

    return String.localizedStringWithFormat(
      NSLocalizedString("widget_updated_format", comment: ""),
      date.formatted(date: .omitted, time: .shortened)
    )
  }
}

@main
struct VRCNFriendStatusWidget: Widget {
  private func makeWidgetConfiguration() -> some WidgetConfiguration {
    if #available(iOSApplicationExtension 17.0, *) {
      return AppIntentConfiguration(
        kind: widgetKind,
        intent: FriendStatusConfiguration.self,
        provider: ConfigurableFriendStatusProvider()
      ) { entry in
        FriendStatusWidgetView(entry: entry)
      }
    } else {
      return StaticConfiguration(kind: widgetKind, provider: LegacyFriendStatusProvider()) { entry in
        FriendStatusWidgetView(entry: entry)
      }
    }
  }

  var body: some WidgetConfiguration {
    makeWidgetConfiguration()
      .configurationDisplayName("widget_name")
      .description("widget_description")
      .supportedFamilies([.systemSmall, .systemMedium])
  }
}
