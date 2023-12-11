import SwiftUI
import SwiftData

struct FoodDetail: View {
    var food: Food
    var body: some View {
        ScrollView{
            Text("\(food.name ?? "N/A")")
                .font(.largeTitle)
            
            Rectangle()
                .foregroundColor(.gray)
                .frame(minHeight: 200)
                
            Spacer()
            Text("Info")
            Text("Calories: \(food.calories)")
            Text("Protein: \(food.protein)")
            Text("Sugar: \(food.sugars)")
        }
     
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Food.self, configurations: config)

    let food1 = Food(name: "food1", quantity: 10, calories: 3, protein: 10, sugars: 22.2)
    container.mainContext.insert(food1)

    
    return FoodDetail(food: food1)
        .modelContainer(container)
}
