import Foundation
import SwiftData

@Model
class Food {
    @Attribute(.unique) var id: UUID
    var date: Date
    var quantity: Int
    var calories: Double
    var protein: Double
    var sugars: Double
    
    
    init(date: Date, quantity: Int, calories: Double, protein: Double, sugars: Double){
        self.id = UUID.init()
        self.date = date
        self.quantity = quantity
        self.calories = calories
        self.protein = protein
        self.sugars = sugars
        
    }
    
}

@Model
class Meal{
    @Attribute(.unique) var id: UUID
    var foodItems: [Food]
    var totalCalorites: Double
    var totalProtein: Double
    var totalSugars: Double
    
    init() {
        self.id = UUID.init()
        self.foodItems = []
        self.totalCalorites = 0
        self.totalProtein = 0
        self.totalSugars = 0
    }
    
}

