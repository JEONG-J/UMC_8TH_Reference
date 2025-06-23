//
//  ReceiptViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import Foundation
import SwiftUI
import PhotosUI

@Observable
class ReceiptViewModel {
    // MARK: - State Property
    var showConfirmDialog: Bool = false
    var showPhotoPicker: Bool = false
    var showFullImage: Bool = false
    
    // MARK: - Property
    var selectedItem: PhotosPickerItem?
    var identifiableImageData: IdentifiableImageData? = nil
    var selectedImage: UIImage?
    var recognizedReceipt: ReceiptModel?
    
    private let ocrManager: OCRManager = .init()
    
    // MARK: - Method
    public func actionConfirDialog(_ action: ConfirmDialogType) async {
        switch action {
        case .photoLibray:
            self.showPhotoPicker.toggle()
        case .camera:
            print("아무것도 없어요!")
        case .cancel:
            break
        }
    }
    
    public func loadImage(_ item: PhotosPickerItem?) async {
        guard let item = item else { return }

        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                self.selectedImage = uiImage
                
                if let parsed = try? await ocrManager.recognizeReceipt(image: uiImage) {
                    parsed.imageData = uiImage.jpegData(compressionQuality: 0.8)
                    self.recognizedReceipt = parsed
                    print("OCR 결과: \(parsed)")
                } else {
                    print("OCR 결과 없음")
                }
            }
        } catch {
            print("이미지 로드 실패", error.localizedDescription)
        }
    }
    
    public func resetRecognizedReceipt() {
        recognizedReceipt = nil
        selectedImage = nil
        selectedItem = nil
    }
}
