//
//  StringHelpers.swift
//  PageSpeed
//
//  Created by Alex on 2/5/20.
//  Copyright © 2020 Stanford University. All rights reserved.
//

import UIKit

extension String {
    var isValidURL: Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }

    func base64Convert() -> UIImage? {
        let base64StrArr = self.components(separatedBy: ",")
        if let imageData = Data(base64Encoded: base64StrArr.last!, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: imageData)
            return image
        }
        return nil
    }

    func convertFormatedStringToFormatedDate() -> String {
        var strDate = "undefined"
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let date = dateFormater.date(from: self) {
            let timeZone = TimeZone.current.abbreviation() ?? "UTC"
            dateFormater.timeZone = TimeZone(abbreviation: timeZone)
            dateFormater.locale = NSLocale.current
            dateFormater.dateFormat = "dd/MM/yyyy HH:mm:ss"
            strDate = dateFormater.string(from: date)
        }

        return strDate
    }
}
