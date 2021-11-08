//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 7/11/21.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM yyyy"
        
        return dateFormater.string(from: self)
    }
}
