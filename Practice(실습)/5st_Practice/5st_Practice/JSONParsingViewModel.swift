//
//  JSONParsingViewModel.swift
//  5st_Practice
//
//  Created by Apple Coding machine on 4/10/25.
//

import Foundation

@Observable
class JSONParsingViewModel {
    var myProfile: MyModel?
    
    func loadMyProfile(completion: @escaping (Result<MyModel, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("json 파일 없음")
            completion(.failure(NSError(domain: "파일 못찾아요!", code: 404, userInfo: nil)))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(MyModel.self, from: data)
            self.myProfile = decoded
            print("디코딩 성공")
            completion(.success(decoded))
        } catch {
            print("디코딩 실패: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}
