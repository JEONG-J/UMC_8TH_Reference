//
//  ISBNScannerViewModel.swift
//  6st_Practice
//
//  Created by Apple Coding machine on 5/4/25.
//

import Foundation
import Alamofire
import SwiftUI

@Observable
class ISBNScannerViewModel {
    
    var bookModel: BookModel.Documents?
    var errorMessage: String?
    
    var isShowSaveView: Bool = false
    
    func searchBook(isbn: String) async {
        
        self.errorMessage = nil
        
        do {
            let result = try await KakaoAPIService.shared.searchBook(query: isbn)
            self.bookModel = result.documents.first
            self.isShowSaveView = true
        } catch {
            self.errorMessage = error.localizedDescription
            print("전체 에러 정보:", error)
        }
    }
    
    
    public func purchaseBook() {
        if let urlString = self.bookModel?.url,
           let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("구매 링크 연결 x")
        }
    }
}



