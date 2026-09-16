import SwiftUI

struct ContentView: View {
    // State variable to trigger UI updates when the value changes
    @State private var count = 0

    var body: some View {
        // VStack arranges child views in a vertical line
        VStack(spacing: 20) {
            
            Text("Current Count: \(count)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Button(action: {
                // Increment the count by 1
                count += 1
            }) {
                Text("Increment")
                    .font(.headline)
                    .padding()
                    .frame(width: 150)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Button(action: {
                // Reset the count back to 0
                count = 0
            }) {
                Text("Reset")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
