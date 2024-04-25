//
//  ContentView.swift
//  getDataCombine
//
//  Created by Iliiah on 25.04.24.
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

class DownloadWithCombineViewModel: ObservableObject {
    @Published var people: [Person] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://raw.githubusercontent.com/iliajs/sandbox/main/MockData/People1.json") else { return }
        
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

struct DownloadWithCombine: View {
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.people) { person in
                VStack(alignment: .leading, spacing: 20) {
                    Text("id: " + String(person.id)).foregroundColor(.gray).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    Text("first_name: " + person.first_name).font(.largeTitle).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}


