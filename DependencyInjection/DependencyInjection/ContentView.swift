//
//  ContentView.swift
//  DependencyInjection
//
//  Created by Pjot on 23.11.2022.
//

import SwiftUI
import Combine

// PROBLEMS WITH SINGLETONS
// 1. Singelton's are global / can affect app if called/accessed by more views, classes, structs...
// 2. Cant't customize init!
// 3. Can't swap out dependecies

struct PostsModel: Identifiable, Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    
    func getData() -> AnyPublisher<[PostsModel], Error>
}

class ProductionDataService: DataServiceProtocol {
    
//    static let instance = ProductionDataService() // singelton / instead use injections
    
    let url: URL
    
    init (url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    
    let testData: [PostsModel] = [
        PostsModel(userId: 1, id: 1, title: "One", body: "One"),
        PostsModel(userId: 2, id: 2, title: "Two", body: "Two")
    ]
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
    
}

class DependencyInjectionViewModel: ObservableObject {
    
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)

    
    }
}

struct ContentView: View {
    
    @StateObject private var vm: DependencyInjectionViewModel
    
    init (dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
//    static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    
    static let dataService = MockDataService()
    
    static var previews: some View {
        ContentView(dataService: dataService)
    }
}
