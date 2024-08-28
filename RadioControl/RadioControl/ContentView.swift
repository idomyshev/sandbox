//
//  ContentView.swift
//  RadioControl
//
//  Created by Iliiah on 28.08.24.
//

import SwiftUI
import Combine

struct Person: Identifiable, Codable {
    let id: Int
    let first_name: String
}

struct ApiResponse: Codable {
    let records: [Person]
}

class CallApi: ObservableObject {
    @Published var people: [Person] = []
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        //
    }
    
    func callApi(operation: String, speed: Int) {
        guard let url = URL(string: "http://192.168.4.1/\(operation)/\(String(speed))") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
                
            }.decode(type: ApiResponse.self, decoder: JSONDecoder())
            .sink { (completion) in
                print("COMPLETION: \(completion)")
            } receiveValue: { [weak self] (apiResponse) in
                self?.people = apiResponse.records
            }.store(in: &cancellables)
    }
}

struct ContentView: View {
    @StateObject private var vm = CallApi()
    
    @State private var dragOffset: CGSize = .zero
    @State private var position: CGSize = .zero
    
    @State private var aaCurrent: CGSize = .zero
    @State private var aaSaved: CGSize = .zero
    
    
    @State var currentY: Double = .zero;
    @State var savedY: Double = .zero;
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color.red)
                .shadow(radius: 20)
                .frame(width: 100)
                .offset(x: dragOffset.width + position.width, y: dragOffset.height + position.height)
                .gesture(DragGesture()
                    .onChanged({ (value) in
                        self.dragOffset = value.translation
                    })
                        .onChanged({
                            (value) in currentY = value.translation.height
                            

                            
                            
                        })
                        .onEnded({ (value) in
                            
                            self.position.width += value.translation.width
                            
                            self.position.height += value.translation.height
                            
                            self.dragOffset = .zero
                            
                            savedY = savedY + currentY;
                            
                            vm.callApi(operation: "on", speed: Int(savedY))
                            
                            currentY = .zero
                        })
                )
            
            Text("Horizontal Swift: \(dragOffset.width, specifier: "%.2f")°")
                .padding()
            
            Text("Current Y: \(currentY)")
                .padding()
            
            Text("Saved Y: \(savedY)")
                .padding()
            
            Text("Result Y: \(Int(savedY + currentY))")
                .padding()
        }
    }
}

#Preview {
    ContentView()
}
