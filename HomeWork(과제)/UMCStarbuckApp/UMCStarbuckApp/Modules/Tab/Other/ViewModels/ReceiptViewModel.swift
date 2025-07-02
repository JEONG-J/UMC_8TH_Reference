//
//  ReceiptViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/22/25.
//

import Foundation
import SwiftUI
import PhotosUI

/// 영수증 관련 뷰 로직을 담당하는 ViewModel
@Observable
class ReceiptViewModel {
    
    // MARK: - 상태를 나타내는 프로퍼티
    
    /// 확인 다이얼로그 표시 여부
    var showConfirmDialog: Bool = false
    
    /// 사진 선택기 표시 여부
    var showPhotoPicker: Bool = false
    
    /// 전체 이미지 보기 뷰 표시 여부
    var showFullImage: Bool = false
    
    /// 로딩 상태 여부 (OCR 처리 중 등)
    var isLoading: Bool = false
    
    // MARK: - 데이터 관련 프로퍼티
    
    /// 사용자가 선택한 PhotosPickerItem
    var selectedItem: PhotosPickerItem?
    
    /// 전체 이미지 보기 시 필요한 식별 가능한 이미지 데이터
    var identifiableImageData: IdentifiableImageData? = nil
    
    /// 선택된 UIImage
    var selectedImage: UIImage?
    
    /// OCR 인식된 영수증 정보
    var recognizedReceipt: ReceiptModel?
    
    /// OCR 매니저 인스턴스 (Vision 기반 인식 수행)
    private let ocrManager: OCRManager = .init()
    
    // MARK: - 사용자 액션 핸들링 메서드
    
    /// 확인 다이얼로그의 액션 처리
    /// - Parameter action: 사용자가 선택한 다이얼로그 액션
    public func actionConfirDialog(_ action: ConfirmDialogType) async {
        switch action {
        case .photoLibray:
            // 사진 보관함 열기
            self.showPhotoPicker.toggle()
        case .camera:
            // 카메라는 아직 미구현
            print("아무것도 없어요!")
        case .cancel:
            break
        }
    }
    
    /// 선택된 사진 아이템을 불러와 OCR 처리까지 수행
    /// - Parameter item: 선택한 PhotosPickerItem
    public func loadImage(_ item: PhotosPickerItem?) async {
        isLoading = true
        guard let item = item else { return }

        do {
            // 데이터로 변환 후 UIImage 생성
            if let data = try await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                self.selectedImage = uiImage
                
                // OCR 결과 처리
                if let parsed = try? await ocrManager.recognizeReceipt(image: uiImage) {
                    parsed.imageData = uiImage.jpegData(compressionQuality: 0.8) // 이미지 데이터 압축 저장
                    self.recognizedReceipt = parsed
                    print("OCR 결과: \(parsed)")
                } else {
                    print("OCR 결과 없음")
                }
            }
        } catch {
            print("이미지 로드 실패", error.localizedDescription)
        }
        isLoading = false
    }
    
    /// OCR 결과 및 관련 이미지 리셋
    public func resetRecognizedReceipt() {
        recognizedReceipt = nil
        selectedImage = nil
        selectedItem = nil
    }
}
