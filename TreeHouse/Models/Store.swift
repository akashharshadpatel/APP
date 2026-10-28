import Foundation
import CoreLocation

struct StoreHours: Codable, Hashable, Identifiable {
    /// 1 = Sunday … 7 = Saturday (matches `Calendar` weekday numbering).
    var weekday: Int
    /// Minutes after midnight.
    var opensAt: Int
    var closesAt: Int

    var id: Int { weekday }

    var weekdayName: String { Calendar.current.weekdaySymbols[weekday - 1] }

    var rangeLabel: String { "\(Self.label(opensAt)) – \(Self.label(closesAt))" }

    private static func label(_ minutes: Int) -> String {
        var components = DateComponents()
        components.hour = minutes / 60
        components.minute = minutes % 60
        let date = Calendar.current.date(from: components) ?? .now
        return date.formatted(date: .omitted, time: .shortened)
    }
}

struct StoreInfo: Codable, Hashable {
    var name: String
    var subtitle: String
    var licenseNumber: String
    var street: String
    var city: String
    var state: String
    var postalCode: String
    var phoneNumber: String
    var latitude: Double
    var longitude: Double
    var hours: [StoreHours]

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var fullAddress: String { "\(street), \(city), \(state) \(postalCode)" }

    func hours(on date: Date, calendar: Calendar = .current) -> StoreHours? {
        let weekday = calendar.component(.weekday, from: date)
        return hours.first { $0.weekday == weekday }
    }

    func isOpen(at date: Date = .now, calendar: Calendar = .current) -> Bool {
        guard let today = hours(on: date, calendar: calendar) else { return false }
        let minutes = calendar.component(.hour, from: date) * 60 + calendar.component(.minute, from: date)
        return minutes >= today.opensAt && minutes < today.closesAt
    }
}
