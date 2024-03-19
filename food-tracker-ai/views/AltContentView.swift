import SwiftUI
import SwiftData

struct AltContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Day.date, order: .reverse) private var days: [Day]
    var body: some View {
        List(days) { day in
            VStack(alignment: .leading){
                Group{
                    if Calendar.current.isDateInToday(day.date){
                        Text("Today")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    } else if Calendar.current.isDateInYesterday(day.date){
                        Text("Yesterday")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    else{
                        Text(day.displayString())
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                }
                
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Day.self, configurations: config)
    
    let today = Date()
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to:today) ?? Date();
    let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to:today) ?? Date();
    
    let todayDay = Day(date: today)
    let yesterdayDay = Day(date: yesterday)
    let twoDaysAgoDay = Day(date: twoDaysAgo)
    container.mainContext.insert(todayDay)
    container.mainContext.insert(yesterdayDay)
    container.mainContext.insert(twoDaysAgoDay)
    return AltContentView()
        .modelContainer(container)
}
