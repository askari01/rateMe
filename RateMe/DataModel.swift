//
//  DataModel.swift
//  RateMe
//
//  Created by Syed Askari on 31/01/2018.
//  Copyright © 2018 Syed Askari. All rights reserved.
//

import Foundation

struct DataModel: Codable {
    var name: String?
    var receiptNumber: String?
    var rating: Float?

    init?(name: String, receiptNumber: String, rating: Float) {
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }

        guard !receiptNumber.isEmpty else {
            return nil
        }

        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }

        self.name = name
        self.receiptNumber = receiptNumber
        self.rating = rating
    }
}
