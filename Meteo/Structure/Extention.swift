//
//  Extention.swift
//  Meteo
//
//  Created by Massimiliano on 26/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import Foundation
extension Double {
    func twoDecimalNumbers(place: Int) -> Double{
        let divisor = pow(10.0, Double(place))
        return (self * divisor).rounded() / divisor
    }
}


extension String {
    func toDate(dateFormat: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        let date: Date? = dateFormatter.date(from: self)
        return date
}
    
    func lessSpaces(citta : String) -> String{
        var indice = 0
        for i in citta {
            if i == " "{
                
            }
        }
        return ""
    }
}


extension NSDate {
    func asString(style: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self as Date)
    }
    
   
}
