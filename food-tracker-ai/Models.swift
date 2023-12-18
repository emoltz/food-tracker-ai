import Foundation
import SwiftUI
import SwiftData

@Model
class Food {
    @Attribute(.unique) var id: UUID
    var name: String?
    var date: Date
    var quantity: Int
    var calories: Double
    var protein: Double
    var sugars: Double
    var aiDescription: String
    
    
    init(name: String, quantity: Int, calories: Double, protein: Double, sugars: Double, aiDescription: String=""){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let date = Date()
        
        self.id = UUID.init()
        self.name = name
        self.date = date
        self.quantity = quantity
        self.calories = calories
        self.protein = protein
        self.sugars = sugars
        self.aiDescription = aiDescription
    }
    
    func addOrUpdateFoodDescription(foodDescription: String){
        self.aiDescription = foodDescription
    }
}

@Model
class Meal{
    @Attribute(.unique) var id: UUID
    var foodItems: [Food]
    var totalCalorites: Double
    var totalProtein: Double
    var totalSugars: Double
    var name: String
    var dateCreated: Date
    var dateDisplay: String
    var imageName: String
    var compositeDescription: String
    
    init(name: String = "New Meal", imageName: String = "defaultImage", foodItems: [Food] = []) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let date = Date()

        
        self.id = UUID.init()
        self.foodItems = []
        self.totalCalorites = 0
        self.totalProtein = 0
        self.totalSugars = 0
        self.name = name
        self.dateCreated = date
        self.dateDisplay = dateFormatter.string(from: date)
        self.imageName = imageName
        self.compositeDescription = ""
        self.foodItems = foodItems
        
        
    }
    
    func addFoodItem(newFood: Food){
        self.foodItems.append(newFood)
        addCalculations(food: newFood)
        
    }
    
    func compileCompositDescription(){
        self.compositeDescription = "The following is a description of the entire meal: "
        for item in self.foodItems{
            self.compositeDescription += item.aiDescription
            self.compositeDescription += "\n"
        }
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
