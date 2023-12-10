import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var meals: [Meal]
    
    var body: some View {
        
        List(meals) { meal in
            VStack(alignment: .leading){
                Text("Meal Name: \(meal.name)")
                Text("Meal Calories: \(meal.totalCalorites)")
                
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Meal.self, Food.self, configurations: config)

    // Insert dummy data
    let food1 = Food(name: "food1", date: Date.now, quantity: 10, calories: 10, protein: 10, sugars: 22.2)
    let food2 = Food(name: "food2", date: Date.now, quantity: 30, calories: 284.2, protein: 18.2, sugars: 11.1)
    let meal = Meal(name: "Meal1")
    meal.addFoodItem(newFood: food1)
    container.mainContext.insert(food1)
    container.mainContext.insert(food2)
    container.mainContext.insert(meal)

    return ContentView()
        .modelContainer(container)
}
