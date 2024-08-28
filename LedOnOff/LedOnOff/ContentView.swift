//
//  ContentView.swift
//  LedOnOff
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
    
    func ledOn() {
        guard let url = URL(string: "http://192.168.4.1/on") else { return }
        
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
    
    func ledOff() {
        guard let url = URL(string: "http://192.168.4.1/off") else { return }
        
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
    
    var body: some View {
        VStack {
                        Button(action: {
                            vm.ledOn()  // Call the method from MyClass
                                    }) {
                                        Text("Led On")
                                    }.padding().padding().font(.system(size: 46)).foregroundColor(.blue)
            
                        Button(action: {
                            vm.ledOff()  // Call the method from MyClass
                                    }) {
                                        Text("Led Off")
                                    }.font(.system(size: 46)).foregroundColor(.red)
                        
                        List {
                            ForEach(vm.people) { person in
                                VStack(alignment: .leading, spacing: 20) {
                                    Text("id: " + String(person.id)).foregroundColor(.gray).font(.title)
                                    Text("first_name: " + person.first_name).font(.largeTitle).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                }
                            }
                        }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
