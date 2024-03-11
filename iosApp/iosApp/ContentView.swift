import KMPNativeCoroutinesAsync
import SwiftUI
import shared

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel

    let phrases = Greeting().greetList()

    var body: some View {
        VStack{
            ListView(phrases: phrases)
            ListView(phrases: viewModel.greetingList)
                .onAppear { self.viewModel.startObserving() }
        }
    }
}

struct ListView: View {
    let phrases: Array<String>
    
    var body: some View {
        List(phrases, id: \.self) {
            Text($0)
        }
    }
}

extension ContentView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var greetingList: Array<String> = []

        func startObserving() {
            Task{
                do {
                    let sequence = asyncSequence(for: Greeting().greetFlow())
                    for try await phrase in sequence {
                        self.greetingList.append(phrase)
                    }
                } catch {
                    print("Failed with error: \(error)")
                }
            }
        }
    }
}
