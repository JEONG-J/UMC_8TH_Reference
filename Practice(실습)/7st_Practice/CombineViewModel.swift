//
//  CombineViewModel.swift
//  7st_Practice
//
//  Created by Apple Coding machine on 5/24/25.
//

import Foundation
import CombineMoya
import Combine
import Moya

class CombineViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    private let provider: MoyaProvider<UserRotuer>
    
    @Published var userName: String = ""
    @Published var isLoading: Bool = false
    @Published var userData: UserData? = nil
    
    init(provider: MoyaProvider<UserRotuer> = APIManager.shared.createProvider(for: UserRotuer.self)) {
        
        self.provider = provider
        
        $userName
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .flatMap { name in
                self.getUser(name: name)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$userData)
    }
    
    private func getUser(name: String) -> AnyPublisher<UserData?, Never> {
           provider.requestPublisher(.getPerson(name: name))
               .handleEvents(
                   receiveSubscription: { _ in
                       DispatchQueue.main.async {
                           self.isLoading = true
                       }
                   },
                   receiveCompletion: { _ in
                       DispatchQueue.main.async {
                           self.isLoading = false
                       }
                   }
               )
               .map(\.data)
               .decode(type: UserData.self, decoder: JSONDecoder())
               .map { Optional($0) }
               .catch { error -> Just<UserData?> in
                   DispatchQueue.main.async {
                       print("에러: \(error.localizedDescription)")
                   }
                   return Just(nil)
               }
               .eraseToAnyPublisher()
       }
}

