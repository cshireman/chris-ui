//
//  ProfileCard.swift
//  ChrisUI
//
//  Created by Chris Shireman on 12/4/25.
//

import SwiftUI

/// A card component for displaying user profile information
///
/// A pre-styled card optimized for displaying user profiles with an avatar,
/// name, subtitle, and optional chevron indicator. Commonly used in lists,
/// settings screens, or user directories.
///
/// Example:
/// ```swift
/// ProfileCard(
///     name: "John Doe",
///     subtitle: "Software Engineer",
///     onTap: { print("Profile tapped") }
/// )
/// ```
public struct ProfileCard: View {
    let name: String
    let subtitle: String?
    let avatarImage: String?
    let onTap: (() -> Void)?

    var showChevron: Bool = true
    var backgroundColor: Color = .init(.systemBackground)

    /// Creates a profile card
    /// - Parameters:
    ///   - name: The user's name or title
    ///   - subtitle: Optional subtitle (e.g., job title, description)
    ///   - avatarImage: Optional SF Symbol name for the avatar (default: person.circle.fill)
    ///   - showChevron: Whether to show the trailing chevron indicator (default: true)
    ///   - backgroundColor: Background color of the card (default: system background)
    ///   - onTap: Optional action to execute when the card is tapped
    public init(
        name: String,
        subtitle: String? = nil,
        avatarImage: String? = nil,
        showChevron: Bool = true,
        backgroundColor: Color = Color(.systemBackground),
        onTap: (() -> Void)? = nil
    ) {
        self.name = name
        self.subtitle = subtitle
        self.avatarImage = avatarImage
        self.showChevron = showChevron
        self.backgroundColor = backgroundColor
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: {
            onTap?()
        }) {
            HStack(spacing: 16) {
                // Avatar
                Group {
                    if let avatarImage = avatarImage {
                        Image(systemName: avatarImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .frame(width: 60, height: 60)
                .foregroundStyle(.secondary)
                .clipShape(Circle())

                // Content
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.headline)
                        .foregroundStyle(.primary)

                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                Spacer()

                // Chevron
                if showChevron {
                    Image(systemName: "chevron.right")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
        }
        .buttonStyle(.plain)
    }
}

/// Extended profile card with additional statistics display
///
/// An enhanced version of ProfileCard that includes a statistics section,
/// commonly used in social media profiles or user dashboards to display
/// metrics like followers, posts, or reviews.
///
/// Example:
/// ```swift
/// ProfileCardExtended(
///     name: "John Doe",
///     subtitle: "Software Engineer",
///     stats: [
///         .init(label: "Posts", value: "128"),
///         .init(label: "Followers", value: "1.2K"),
///         .init(label: "Following", value: "456")
///     ],
///     onTap: { print("Profile tapped") }
/// )
/// ```
public struct ProfileCardExtended: View {
    let name: String
    let subtitle: String?
    let avatarImage: String?
    let stats: [ProfileStat]
    let onTap: (() -> Void)?

    /// Represents a single statistic displayed in the profile card
    public struct ProfileStat: Identifiable {
        public let id = UUID()
        public let label: String
        public let value: String

        /// Creates a profile statistic
        /// - Parameters:
        ///   - label: The label for the statistic (e.g., "Posts", "Followers")
        ///   - value: The value to display (e.g., "128", "1.2K")
        public init(label: String, value: String) {
            self.label = label
            self.value = value
        }
    }

    /// Creates an extended profile card with statistics
    /// - Parameters:
    ///   - name: The user's name or title
    ///   - subtitle: Optional subtitle (e.g., job title, location)
    ///   - avatarImage: Optional SF Symbol name for the avatar
    ///   - stats: Array of statistics to display
    ///   - onTap: Optional action to execute when the card is tapped
    public init(
        name: String,
        subtitle: String? = nil,
        avatarImage: String? = nil,
        stats: [ProfileStat],
        onTap: (() -> Void)? = nil
    ) {
        self.name = name
        self.subtitle = subtitle
        self.avatarImage = avatarImage
        self.stats = stats
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: {
            onTap?()
        }) {
            VStack(spacing: 16) {
                // Header
                HStack(spacing: 16) {
                    // Avatar
                    Group {
                        if let avatarImage = avatarImage {
                            Image(systemName: avatarImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.secondary)
                    .clipShape(Circle())

                    // Content
                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)

                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()
                }

                // Stats
                if !stats.isEmpty {
                    Divider()

                    HStack(spacing: 0) {
                        ForEach(Array(stats.enumerated()), id: \.element.id) { index, stat in
                            VStack(spacing: 4) {
                                Text(stat.value)
                                    .font(.headline)
                                    .foregroundStyle(.primary)

                                Text(stat.label)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity)

                            if index < stats.count - 1 {
                                Divider()
                                    .frame(height: 30)
                            }
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
        }
        .buttonStyle(.plain)
    }
}

#Preview("Basic Profile Card") {
    VStack(spacing: 20) {
        ProfileCard(
            name: "John Doe",
            subtitle: "Software Engineer",
            onTap: { print("Profile tapped") }
        )

        ProfileCard(
            name: "Jane Smith",
            subtitle: "Product Designer",
            avatarImage: "person.crop.circle.fill",
            showChevron: false,
            onTap: nil
        )
    }
    .padding()
}

#Preview("Extended Profile Card") {
    VStack(spacing: 20) {
        ProfileCardExtended(
            name: "John Doe",
            subtitle: "Software Engineer",
            stats: [
                .init(label: "Posts", value: "128"),
                .init(label: "Followers", value: "1.2K"),
                .init(label: "Following", value: "456"),
            ],
            onTap: { print("Profile tapped") }
        )

        ProfileCardExtended(
            name: "Jane Smith",
            subtitle: "Product Designer • San Francisco",
            avatarImage: "person.crop.circle.fill",
            stats: [
                .init(label: "Projects", value: "24"),
                .init(label: "Reviews", value: "89"),
            ],
            onTap: { print("Profile tapped") }
        )
    }
    .padding()
}
