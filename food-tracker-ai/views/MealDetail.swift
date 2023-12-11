import SwiftUI
import SwiftData

struct MealDetail: View {
    var meal: Meal
    var body: some View {
        VStack {
            Text("\(meal.name)")
                .font(.headline)
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .scaledToFit()
                .padding(30)
            
            List(meal.foodItems){ food in
                Section{
                    Text(food.name ?? "Food1")
                } header: {
                    Text("Food in the meal")
                }
                
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Meal.self, configurations: config)

    let food1 = Food(name: "food1", quantity: 10, calories: 10, protein: 10, sugars: 22.2)
    let food2 = Food(name: "food2", quantity: 3, calories: 10, protein: 10, sugars: 22.2)
    // Create a sample Meal instance
    let sampleMeal = Meal(name: "Sample Meal")
    sampleMeal.addFoodItem(newFood: food2)
    
    
    // If Meal class has other properties, initialize them as needed
    // Then insert the meal into the container's context
    container.mainContext.insert(sampleMeal)

    // Return the SwiftUIView with the sample Meal
    return MealDetail(meal: sampleMeal)
        .modelContainer(container)
}
