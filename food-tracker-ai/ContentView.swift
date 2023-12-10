import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var meals: [Meal]
    
    var body: some View {
        NavigationStack{
            
            List(meals) { meal in
                
                VStack(alignment: .leading){
                    
                    Text("Date: \(meal.dateDisplay)")
                        .font(.headline)
                    Text("Meal Name: \(meal.name)")
                    Text("Meal Calories: \(meal.totalCalorites)")
                    
                }
                
                .navigationTitle("Your Stuff")
                
            }
            
            
            
            .toolbar{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "plus.app.fill")
                        .imageScale(.large)
                        .foregroundColor(.black)
                })
            }
        }
        
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Meal.self, Food.self, configurations: config)
    
    // Insert dummy data
    let food1 = Food(name: "food1", quantity: 10, calories: 10, protein: 10, sugars: 22.2)
    let food2 = Food(name: "food2", quantity: 30, calories: 284.2, protein: 18.2, sugars: 11.1)
    let food3 = Food(name: "Food3", quantity: 30, calories: 21, protein: 1, sugars: 30.2)
    let meal1 = Meal()
    let meal2 = Meal(name: "Meal 2")
    let meal3 = Meal()
    meal2.addFoodItem(newFood: food1)
    meal1.addFoodItem(newFood: food1)
    meal3.addFoodItem(newFood: food3)
    container.mainContext.insert(food1)
    container.mainContext.insert(food2)
    container.mainContext.insert(meal1)
    container.mainContext.insert(meal2)
    container.mainContext.insert(meal3)
    
    return ContentView()
        .modelContainer(container)
}
