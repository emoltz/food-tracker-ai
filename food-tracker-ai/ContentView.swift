import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var meals: [Meal]
    @State private var showingAddMealSheet = false
    @State private var showPersonalInfo = false
    var body: some View {
        NavigationStack {
            List(meals) { meal in
                NavigationLink(destination: MealDetail(meal: meal)) {
                    VStack(alignment: .leading) {
                        Text("Date: \(meal.dateDisplay)")
                            .font(.headline)
                        Text("Meal Name: \(meal.name)")
                        Text("Meal Calories: \(meal.totalCalories)")
                    }
                }
            }
            .navigationTitle("Your Meals")
            .toolbar {
                Button(action: {
                    showPersonalInfo.toggle()
                }, label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                })
                
                Button(action: {
                    showingAddMealSheet.toggle()
                }, label: {
                    Image(systemName: "plus.app.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                })
            }
            .sheet(isPresented: $showingAddMealSheet){
                AddMeal()
            }
            .sheet(isPresented: $showPersonalInfo, content: {
                Text("Hello")
            })
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
    let meal1 = Meal(imageName: "dinner3")
    let meal2 = Meal(name: "Meal 2", imageName: "dinner2")
    let meal3 = Meal(imageName: "dinner1")
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
