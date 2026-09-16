import SwiftUI
import UIKit

struct ContentView: View {
    // State for the current count
    @State private var count = 0
    // State for the increment/decrement step size
    @State private var step = 1
    // State to store saved history records
    @State private var savedHistory: [Int] = []

    var body: some View {
        NavigationView {
            ZStack {
                // Setting a light gray background for the whole screen
                Color(UIColor.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 25) {
                    
                    // 1. Counter Display Card
                    VStack(spacing: 10) {
                        Text("CURRENT COUNT")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .tracking(2)
                        
                        Text("\(count)")
                            // Using a rounded, monospaced-like font for numbers
                            .font(.system(size: 80, weight: .bold, design: .rounded))
                            .foregroundColor(count < 0 ? .red : .primary)
                            // Adding a spring animation when the number changes
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: count)
                        
                        // Step Picker Control
                        Picker("Step Size", selection: $step) {
                            Text("Step: 1").tag(1)
                            Text("Step: 5").tag(5)
                            Text("Step: 10").tag(10)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 30)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)
                    .padding(.horizontal)
                    
                    // 2. Action Buttons (Minus and Plus)
                    HStack(spacing: 30) {
                        // Reusable component for the Minus button
                        CounterButton(icon: "minus", color: .red) {
                            count -= step
                        }
                        
                        // Reusable component for the Plus button
                        CounterButton(icon: "plus", color: .green) {
                            count += step
                        }
                    }
                    
                    // 3. Save & Reset Button
                    Button(action: {
                        // Animate the list insertion and reset
                        withAnimation {
                            if count != 0 {
                                // Insert at the top of the array
                                savedHistory.insert(count, at: 0)
                            }
                            count = 0
                        }
                    }) {
                        Label("Save & Reset", systemImage: "tray.and.arrow.down.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                            .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
                    }
                    .padding(.horizontal)
                    
                    // 4. History List
                    if !savedHistory.isEmpty {
                        List {
                            Section(header: Text("History Log")) {
                                ForEach(savedHistory.indices, id: \.self) { index in
                                    HStack {
                                        Text("Record #\(savedHistory.count - index)")
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text("\(savedHistory[index])")
                                            .fontWeight(.bold)
                                    }
                                }
                                .onDelete(perform: deleteHistory)
                            }
                        }
                        .listStyle(.insetGrouped)
                        .cornerRadius(20)
                        .padding(.horizontal)
                    } else {
                        Spacer() // Push everything up if history is empty
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Smart Counter")
        }
    }
    
    // Function to handle swipe-to-delete
    func deleteHistory(at offsets: IndexSet) {
        savedHistory.remove(atOffsets: offsets)
    }
}

// Custom Reusable View Component
struct CounterButton: View {
    var icon: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            // Apply a subtle haptic feedback when pressed
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
            action()
        }) {
            Image(systemName: icon)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 70, height: 70)
                .background(color.opacity(0.15))
                .foregroundColor(color)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ContentView()
}
