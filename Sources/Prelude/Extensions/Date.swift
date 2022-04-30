import Foundation

public extension Date {

    static var todayString: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: date)
    }
    
    var hour: Int {
        let calendar = Calendar.current
        let diffComponents = calendar.dateComponents([.hour], from: self, to: Date())
        return diffComponents.hour ?? -1
    }

    var timeSinceNowString: String {
        let diff = Calendar.current.dateComponents([.second], from: self, to: Date())
        guard let seconds = diff.second.flatMap(abs) else {
            return description
        }

        let minutesInSeconds = 60
        let hoursInSeconds = 60 * 60
        let daysInSeconds = 60 * 60 * 24
        let monthsInSeconds = 60 * 60 * 24 * 30
        let yearsInSeconds = 60 * 60 * 24 * 365
        switch seconds {
        case Int.min..<0:
            return ""
        case 0..<minutesInSeconds:
            return "\(seconds) seconds ago"
        case minutesInSeconds..<hoursInSeconds:
            let minutes = seconds / minutesInSeconds
            let minutesText = minutes > 1 ? "minutes" : "minute"
            return "\(minutes) \(minutesText) ago"
        case hoursInSeconds..<daysInSeconds:
            let hours = seconds / hoursInSeconds
            let hoursText = hours > 1 ? "hours" : "hour"
            return "\(hours) \(hoursText) ago"
        case daysInSeconds..<monthsInSeconds:
            let days = seconds / daysInSeconds
            let daysText = days > 1 ? "days" : "day"
            return "\(days) \(daysText) ago"
        case monthsInSeconds..<yearsInSeconds:
            let months = seconds / monthsInSeconds
            let monthsText = months > 1 ? "months" : "month"
            return "\(months) \(monthsText) ago"
        default:
            let years = seconds / yearsInSeconds
            let yearsText = years > 1 ? "years" : "year"
            return "\(years) \(yearsText) ago"
        }
    }

    var abbreviatedTimeSinceNowString: String {
        let diff = Calendar.current.dateComponents([.second], from: self, to: Date())
        guard let seconds = diff.second.flatMap(abs) else {
            return description
        }

        let minutesInSeconds = 60
        let hoursInSeconds = 60 * 60
        let daysInSeconds = 60 * 60 * 24
        let monthsInSeconds = 60 * 60 * 24 * 30
        let yearsInSeconds = 60 * 60 * 24 * 365
        switch seconds {
        case Int.min..<0:
            return ""
        case 0..<minutesInSeconds:
            return "\(seconds)s"
        case minutesInSeconds..<hoursInSeconds:
            let minutes = seconds / minutesInSeconds
            return "\(minutes)m"
        case hoursInSeconds..<daysInSeconds:
            let hours = seconds / hoursInSeconds
            return "\(hours)h"
        case daysInSeconds..<monthsInSeconds:
            let days = seconds / daysInSeconds
            return "\(days)d"
        case monthsInSeconds..<yearsInSeconds:
            let months = seconds / monthsInSeconds
            return "\(months)m"
        default:
            let years = seconds / yearsInSeconds
            return "\(years)y"
        }
    }

}
