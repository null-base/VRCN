import SwiftUI
import WidgetKit

private let widgetKind = "FriendStatusWidget"
private let appGroupId = "group.com.null-base.vrchat"
private let storageKey = "friendStatusWidgetFriends"

struct FriendStatusEntry: TimelineEntry {
  let date: Date
  let friends: [FriendStatus]
}

struct FriendStatus: Decodable, Identifiable {
  let id: String
  let name: String
  let status: String
  let statusLabel: String
  let location: String
  let updatedAt: String

  var isOnline: Bool {
    status != "offline"
  }

  var color: Color {
    switch status {
    case "joinMe":
      return .blue
    case "askMe":
      return .orange
    case "busy":
      return .red
    case "offline":
      return .gray
    default:
      return .green
    }
  }
}

struct FriendStatusProvider: TimelineProvider {
  func placeholder(in context: Context) -> FriendStatusEntry {
    FriendStatusEntry(date: .now, friends: [])
  }

  func getSnapshot(
    in context: Context,
    completion: @escaping (FriendStatusEntry) -> Void
  ) {
    completion(FriendStatusEntry(date: .now, friends: loadFriends()))
  }

  func getTimeline(
    in context: Context,
    completion: @escaping (Timeline<FriendStatusEntry>) -> Void
  ) {
    let entry = FriendStatusEntry(date: .now, friends: loadFriends())
    completion(Timeline(entries: [entry], policy: .after(.now.addingTimeInterval(15 * 60))))
  }

  private func loadFriends() -> [FriendStatus] {
    guard
      let payload = UserDefaults(suiteName: appGroupId)?.string(forKey: storageKey),
      let data = payload.data(using: .utf8),
      let friends = try? JSONDecoder().decode([FriendStatus].self, from: data)
    else {
      return []
    }

    return friends
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
        Text("Select online alert friends")
          .font(.caption)
          .foregroundStyle(.secondary)
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
            Text(friend.statusLabel)
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
      return "Updated"
    }

    return "Updated \(date.formatted(date: .omitted, time: .shortened))"
  }
}

@main
struct VRCNFriendStatusWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: widgetKind, provider: FriendStatusProvider()) { entry in
      FriendStatusWidgetView(entry: entry)
    }
    .configurationDisplayName("Friend Status")
    .description("Shows selected VRChat friend online status.")
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}
