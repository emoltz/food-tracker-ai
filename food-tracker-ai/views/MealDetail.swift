import SwiftUI
import SwiftData

struct MealDetail: View {
    var meal: Meal
    var body: some View {
        VStack {
            Image(meal.imageName)
                .resizable()
            //                .scaledToFit()
            //                .padding(30)
            
            VStack{
                Text(meal.compositeDescription)
                    .font(.caption)
            }
            
            List(meal.getFoodItems()){ food in
                NavigationLink(destination: FoodDetail(food: food)){
                    Text(food.name ?? "")
                }
            }
            
        }
        .navigationTitle(meal.name)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Meal.self, configurations: config)
    
    let food1 = Food(name: "food1", quantity: 10, calories: 10, protein: 10, sugars: 22.2)
    let food2 = Food(name: "food2", quantity: 3, calories: 10, protein: 10, sugars: 22.2)
    let foods = [food1, food2]
    // Create a sample Meal instance
    let sampleMeal = Meal(name: "Sample Meal", imageName: "dinner1", foodItems: foods)
    sampleMeal.compositeDescription = "Test description"
    
    
    // If Meal class has other properties, initialize them as needed
    // Then insert the meal into the container's context
    container.mainContext.insert(sampleMeal)
    
    // Return the SwiftUIView with the sample Meal
    return MealDetail(meal: sampleMeal)
        .modelContainer(container)
}
