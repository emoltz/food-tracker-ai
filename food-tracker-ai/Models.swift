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
    var foodDescription: String
    
    
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
        self.foodDescription = aiDescription
    }
    
    func addOrUpdateFoodDescription(foodDescription: String){
        self.foodDescription = foodDescription
    }
}

@Model
class Meal{
    @Attribute(.unique) var id: UUID
    private var foodItems: [Food]
    var name: String
    var dateCreated: Date
    var dateDisplay: String
    var imageName: String
    var compositeDescription: String
    var userDescription: String
    var mealType: String // breakfast, lunch, dinner
    
    init(name: String = "New Meal", userDescription: String = "", imageName: String = "defaultImage", foodItems: [Food] = [], mealType: String = "") {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        let date = Date()
        
        self.id = UUID.init()
        self.userDescription = userDescription
        self.foodItems = []
        self.name = name
        self.dateCreated = date
        self.dateDisplay = dateFormatter.string(from: date)
        self.imageName = imageName
        self.compositeDescription = ""
        self.foodItems = foodItems
        self.mealType = mealType
        
    }
    
    func getFoodItems() -> [Food] {
        return self.foodItems
    }
    
    // calculations
    var totalCalories: Double {
        self.getFoodItems().reduce(0) { $0 + $1.calories}
    }
    
    var totalProtein: Double {
        self.getFoodItems().reduce(0) { $0 + $1.protein }
    }
    
    var totalSugars: Double {
        self.getFoodItems().reduce(0) { $0 + $1.sugars }
    }
    
    func addFoodItem(newFood: Food) {
        foodItems.append(newFood)
    }

    func compileCompositeDescription() {
        compositeDescription = "The following is a description of the entire meal: "
        self.getFoodItems().forEach { compositeDescription += "\($0.foodDescription)\n" }
    }

    func removeFoodItem(foodToRemove: Food) {
        foodItems.removeAll { $0.id == foodToRemove.id }
    }
    
}

@Model
class Day {
    @Attribute(.unique) var id: UUID
    var date: Date
    var meals: [Meal]

    init(date: Date) {
        self.id = UUID()
        self.date = date
        self.meals = []
    }
    
    var displayString: String {
        let dateFormatter = DateFormatter()
        let dateString = dateFormatter.string(from: self.date)
        return dateString
    }
    

    // Calculates the total nutritional values for the day
    var totalCalories: Double {
        meals.reduce(0) { $0 + $1.totalCalories }
    }

    var totalProtein: Double {
        meals.reduce(0) { $0 + $1.totalProtein }
    }

    var totalSugars: Double {
        meals.reduce(0) { $0 + $1.totalSugars }
    }

    func addMeal(newMeal: Meal) {
        meals.append(newMeal)
    }

    func removeMeal(mealToRemove: Meal) {
        meals.removeAll { $0.id == mealToRemove.id }
    }
}


@Model
class User {
    @Attribute(.unique) var id: UUID
    var days: [Day]
    
    init() {
        self.id = UUID()
        self.days = []
    }
    
    // Calculates the total nutritional values across all days
    var totalCalories: Double {
        days.reduce(0) { $0 + $1.totalCalories }
    }
    
    var totalProtein: Double {
        days.reduce(0) { $0 + $1.totalProtein }
    }
    
    var totalSugars: Double {
        days.reduce(0) { $0 + $1.totalSugars }
    }
    
    func addDay(newDay: Day) {
        days.append(newDay)
    }
    
    func getDays(from startDate: Date, to endDate: Date) -> [Day] {
         return days.filter { $0.date >= startDate && $0.date <= endDate }
     }
    
}
