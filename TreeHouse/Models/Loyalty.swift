import Foundation

enum LoyaltyTier: String, Codable, CaseIterable, Hashable {
    case seedling, sapling, canopy

    var displayName: String { rawValue.capitalized }

    /// Lifetime points needed to reach this tier.
    var threshold: Int {
        switch self {
        case .seedling: 0
        case .sapling: 500
        case .canopy: 1500
        }
    }

    var symbolName: String {
        switch self {
        case .seedling: "leaf"
        case .sapling: "leaf.fill"
        case .canopy: "tree.fill"
        }
    }

    var perks: [String] {
        switch self {
        case .seedling: ["1 point per $1 spent", "Birthday bonus points"]
        case .sapling: ["1.25 points per $1 spent", "Birthday bonus points", "Early access to deals"]
        case .canopy: ["1.5 points per $1 spent", "Double birthday points", "Early access to deals", "Members-only events"]
        }
    }

    var next: LoyaltyTier? {
        switch self {
        case .seedling: .sapling
        case .sapling: .canopy
        case .canopy: nil
        }
    }

    static func tier(forLifetimePoints points: Int) -> LoyaltyTier {
        allCases.last { points >= $0.threshold } ?? .seedling
    }
}

struct Reward: Codable, Hashable, Identifiable {
    var id: String
    var title: String
    var details: String
    var pointsCost: Int
    var symbolName: String
}

struct PointsActivity: Codable, Hashable, Identifiable {
    var id: String
    var date: Date
    var title: String
    /// Positive for points earned, negative for points redeemed.
    var points: Int
}

struct LoyaltyAccount: Codable, Hashable {
    var points: Int
    var lifetimePoints: Int
    var memberSince: Date
    var rewards: [Reward]
    var activity: [PointsActivity]

    var tier: LoyaltyTier { .tier(forLifetimePoints: lifetimePoints) }

    var pointsToNextTier: Int? {
        tier.next.map { max(0, $0.threshold - lifetimePoints) }
    }

    /// 0…1 progress from the current tier toward the next one.
    var progressToNextTier: Double {
        guard let next = tier.next else { return 1 }
        let span = Double(next.threshold - tier.threshold)
        return min(1, max(0, Double(lifetimePoints - tier.threshold) / span))
    }
}
