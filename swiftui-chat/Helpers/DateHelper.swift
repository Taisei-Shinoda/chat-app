//
//  DateHelper.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/09/01.
//

import Foundation


class DateHelper {
    
    static func chatTimestampFrom(date: Date?) -> String {
        
        guard date != nil else {
            return ""
        }
        
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        return df.string(from: date!)
        
    }
}
