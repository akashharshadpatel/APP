import Foundation

struct UserProfile: Codable, Hashable, Identifiable {
    var id: String
    var firstName: String
    var lastName: String
    var email: String?
    var phoneNumber: String?

    var displayName: String {
        let name = "\(firstName) \(lastName)".trimmingCharacters(in: .whitespaces)
        return name.isEmpty ? "TreeHouse Member" : name
    }
}

/// The parts of an Apple ID credential the backend needs. Keeps `AuthenticationServices`
/// types out of the service layer so it can be mocked.
struct AppleSignInCredential: Hashable {
    var userID: String
    var givenName: String?
    var familyName: String?
    var email: String?
    var identityToken: Data?
}
