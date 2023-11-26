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
    
    func addFoodItem(newFood: Food){
        self.foodItems.append(newFood)
        addCalculations(food: newFood)
        
    }
    
    
    func removeFoodItem(foodToRemove: Food){
        // remove item
        if self.foodItems.contains(where: { $0 === foodToRemove }) {
            self.foodItems.removeAll(where: {$0 === foodToRemove})
            // remove info
            removeCalculations(food: foodToRemove)
            
        }
        else{
            print("food item not in array")
        }
        
    }
    
    func addCalculations(food: Food){
        self.totalSugars += food.sugars
        self.totalProtein += food.protein
        self.totalCalorites += food.calories
    }
    
    func removeCalculations(food: Food){
        self.totalSugars -= food.sugars
        self.totalProtein -= food.protein
        self.totalCalorites -= food.calories
    }
    
    
}

