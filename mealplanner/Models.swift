//
//  Models.swift
//  mealplanner
//
//  Created by Jean Brigonnet on 3/5/23.
//

import Foundation
import SwiftUI

struct MealModel: Decodable {
    var id: Int
    var name: String
    var imageURL: String
    var dayToEat: String
    var ingredients: String
}
