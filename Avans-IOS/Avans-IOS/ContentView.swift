import SwiftUI
import SwiftData

struct Settings: Codable {
    var darkModeEnabled: Bool
}

class SettingsStore: ObservableObject {
    @Published var settings: Settings
    
    init() {
        // Load settings from UserDefaults or set default values
        if let storedSettings = UserDefaults.standard.data(forKey: "settings"),
           let decodedSettings = try? JSONDecoder().decode(Settings.self, from: storedSettings) {
            self.settings = decodedSettings
        } else {
            self.settings = Settings(darkModeEnabled: false)
        }
    }
    
    func saveSettings() {
        if let encoded = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encoded, forKey: "settings")
        }
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @StateObject var settingsStore = SettingsStore() // Create and inject the SettingsStore
    
    @State private var showingSettings = false // State for presenting settings
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
            }
            .navigationBarTitle("Items")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: { showingSettings = true }) { // Show settings on button tap
                Image(systemName: "gearshape")
            })
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView().environmentObject(settingsStore) // Pass the settingsStore to SettingsView
        }
        .environmentObject(settingsStore) // Pass the settingsStore to ContentView
        .colorScheme(settingsStore.settings.darkModeEnabled ? .dark : .light) // Set app's color scheme based on dark mode setting

    }
}

struct SettingsView: View {
    @EnvironmentObject var settingsStore: SettingsStore // Inject settings store
    
    var body: some View {
        VStack {
            Toggle("Dark Mode", isOn: $settingsStore.settings.darkModeEnabled)
                .padding()
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .preferredColorScheme(settingsStore.settings.darkModeEnabled ? .dark : .light) // Apply color scheme to all subviews
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
