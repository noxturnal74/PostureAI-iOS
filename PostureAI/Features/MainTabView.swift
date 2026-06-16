import SwiftUI
import Combine

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: ) {
            HomeView()
                .tabItem {
                    Label(\"Home\", systemImage: \"house.fill\")
                }
                .tag(0)
            
            WorkoutLibraryView()
                .tabItem {
                    Label(\"Workouts\", systemImage: \"figure.strength??\")
                }
                .tag(1)
            
            AnalyticsView()
                .tabItem {
                    Label(\"Analytics\", systemImage: \"chart.bar.fill\")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label(\"Profile\", systemImage: \"person.fill\")
                }
                .tag(3)
        }
        .accentColor(.accent)
        .background(Color.secondaryBackground)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
