import Foundation
import SwiftData


class DummyData{
    var meals: [Meal] = []
    var foods: [Food] = []
    
    init(){
        self.meals = [Meal(), Meal(), Meal()]
        self.foods = [
            Food(name: "food1", date: Date.now, quantity: 10, calories: 10, protein: 10, sugars: 22.2),
            Food(name: "food2", date: Date.now, quantity: 30, calories: 284.2, protein: 18.2, sugars: 11.1),
            Food(name: "food3", date: Date.now, quantity: 34, calories: 5.3, protein: 12.2, sugars: 202.2)
        ]
        
        self.meals[0].addFoodItem(newFood: self.foods[0])
        self.meals[0].addFoodItem(newFood: self.foods[1])
        self.meals[1].addFoodItem(newFood: self.foods[2])
    }
    
    func populateModelContext(_ modelContext: ModelContext){
        meals.forEach { meal in
            modelContext.insert(meal)
        }
        foods.forEach{ food in
            modelContext.insert(food)
        }
    }
}

@Model
class User{
    @Attribute(.unique) var id: UUID
    var firstName: String
    var lastName: String
    var meals: [Meal]
    
    init(id: UUID, firstName: String, lastName: String, meals: [Meal]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.meals = meals
    }
}

@Model
class Food {
    @Attribute(.unique) var id: UUID
    var name: String?
    var date: Date
    var quantity: Int
    var calories: Double
    var protein: Double
    var sugars: Double
    
    
    init(name: String, date: Date, quantity: Int, calories: Double, protein: Double, sugars: Double){
        self.id = UUID.init()
        self.name = name
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
