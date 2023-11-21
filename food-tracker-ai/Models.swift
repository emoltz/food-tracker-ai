import Foundation
import SwiftData

@Model
final class Food {
    @Attribute(.unique) var id: UUID
    var date: Date
    var quantity: Int
    var calories: Double
    var protein: Double
    var sugars: Double
    
    
    init(date: Date, quantity: Int, calories: Double, protein: Double, sugars: Double){
        id = UUID()
        self.date = date
        self.quantity = quantity
        self.calories = calories
        self.protein = protein
        self.sugars = sugars
        
    }
    
}
