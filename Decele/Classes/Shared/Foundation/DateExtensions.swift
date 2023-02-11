//
//  DateExtensions.swift
//  Decele
//
//  Created by Mc Kevin on 27/01/23.
//

public extension Date {
    func string(withFormat format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}

// MARK: - DateFormat
public enum DateFormat: String {
    /// "hh:mm a" example: 7:37 PM
    case timeShort = "hh:mm a"
    /// "hh:mm:ss a" example: 7:37:02 PM
    case timeMedium = "hh:mm:ss a"
    /// "hh:mm:ss a zzzz" example: 7:37:02 PM GMT+3
    case timeLong = "hh:mm:ss a zzzz"
    /// "HH:mm" example: 21:01
    case timeShort24hours = "HH:mm"
    /// "HH:mm:ss" example: 17:37:02
    case timeMedium24hours = "HH:mm:ss"
    /// "dd/MM/yyyy" example: 30/12/19
    case dateShort = "dd/MM/yy"
    /// "MMM dd, yyyy" example: Jan 12, 2017
    case dateMedium = "MMM dd, yyyy"
    /// "MMMM dd, yyyy" example: January 12, 2017
    case dateLong = "MMMM dd, yyyy"
    /// "EEEE, MMMM dd, yyyy" example: Thursday, January 12, 2017
    case dateFull = "EEEE, MMMM dd, yyyy"
    /// "dd/MM/yyyy" example: 30/12/2019
    case date = "dd/MM/yyyy"
    /// "yyyy-MM-dd" example: 2019-12-30
    case dateUS = "yyyy-MM-dd"
    /// "EEEE dd MMMM yyyy" example: jueves 05 noviembre 2018
    case human = "EEEE dd MMMM yyyy"
    /// "EEEE dd/MM/yyyy" example: jueves 30/12/2019
    case humanDate = "EEEE dd/MM/yyyy"
    /// "EEEE dd" example: jueves 05
    case humanDay = "EEEE dd"
    /// "EEEE dd MMMM" example: jueves 05 noviembre
    case humanDayMonth = "EEEE dd MMMM"
    /// "MMMM yyyy" example: noviembre 2018
    case humanMonthYear = "MMMM yyyy"
    /// "dd 'de' MMMM" example:  12 de Octubre
    case humanDayNumberMonth = "dd 'de' MMMM"
    /// "EEEE" example: j
    case dayNameShort = "EEEEE"
    /// "EEEE" example: jue
    case dayNameLong = "EEE"
    /// "EEEE" example: jueves
    case dayNameFull = "EEEE"
    /// "dd" example: 31
    case dayNumber = "dd"
    /// "MMM" example: sep
    case monthShort = "MMMMM"
    /// "MMMM" example: noviembre
    case monthLong = "MMM"
    /// "MMMM" example: noviembre
    case monthFull = "MMMM"
    /// "yyyy" example: 2020
    case yearShort = "yy"
    /// "yyyy" example: 2020
    case yearFull = "yyyy"
    /// yyyyMMddHHmmss example: 20181231235959
    case numeric = "yyyyMMddHHmmss"
    /// yyyy-MM-dd'T'HH:mm:ss.SSSZ
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
}
