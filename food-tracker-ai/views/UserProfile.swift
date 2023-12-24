import SwiftUI
import SwiftData
import Charts

struct UserProfile: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    struct ValuePerCategory {
        var category: String
        var value: Double
    }
    
    
    let data: [ValuePerCategory] = [
        .init(category: "Calories", value: 5),
        .init(category: "Protein", value: 9),
        .init(category: "Sugars", value: 7)
    ]
    var body: some View {
        VStack{
            Text("Hello, User")
            
            Spacer()
            VStack {
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .disabled(endDate < startDate)
            }
            .padding()
            ScrollView {
                Chart(data, id: \.category) { item in
                    BarMark(
                        x: .value("Category", item.category),
                        y: .value("Value", item.value)
                    )
                }
                .frame(width:400, height: 200)
            }
            Spacer()
            Text("Some other stuff")
        }
        
        
    }
}

#Preview {
    UserProfile()
}
