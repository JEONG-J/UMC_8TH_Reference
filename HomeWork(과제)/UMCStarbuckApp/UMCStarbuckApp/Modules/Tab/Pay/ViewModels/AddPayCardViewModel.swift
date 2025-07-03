//
//  AddPayCardViewModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/1/25.
//

import Foundation
import Combine
import SwiftUI

/// AddPayCardView에서 사용하는 ViewModel
@Observable
class AddPayCardViewModel {
    
    // MARK: - 입력 제한 관련 상수
    
    /// 카드 이름의 최대 글자 수
    let maxCardNameCount: Int = 20
    /// 카드 번호의 최대 글자 수
    let maxCardNumberCount: Int = 12
    
    // MARK: - 카드 생성 상태
    
    /// 생성된 카드 이미지
    var generatedImage: UIImage?
    /// 이미지 생성 진행률 (0~100%)
    var progressPercentage: Double = 0
    /// 이미지 생성 중인지 여부
    var isGenerating: Bool = false
    
    // MARK: - 의존성 주입 및 비동기 처리
    
    /// DIContainer를 통해 의존성 주입
    let container: DIContainer
    /// Combine 구독 해제를 위한 Set
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - 사용자 입력
    
    /// 입력된 카드 이름
    var cardName: String = ""
    /// 입력된 카드 번호
    var cardNumber: String = ""
    
    /// 카드 생성 시 랜덤 잔액 (0 ~ 1000억 원)
    var randomBalance: Int {
        Int.random(in: 0...100_000_000_000)
    }
    
    // MARK: - 초기화
    
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - 카드 저장
    
    /// 카드 정보를 모델로 생성하여 반환
    public func saveCard() -> PayCardInfo {
        .init(
            cardName: self.cardName,
            balance: self.randomBalance,
            cardNumber: self.cardNumber,
            imageData: self.generatedImage?.pngData() ?? Data()
        )
    }
    
    // MARK: - 이미지 생성
    
    /// 카드 이미지 생성 시작
    public func generateImageAction() {
        isGenerating = true
        generatedImage = nil
        progressPercentage = 0
        
        pollProgress() // 진행률 업데이트 시작

        let request = Txt2ImgRequest()

        container.useCaseService.stableDiffusionService.gernerateImage(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                // 오류 발생 시 처리
                if case .failure(let failure) = completion {
                    print("이미지 생성 오류: \(failure)")
                    self?.isGenerating = false
                    self?.container.useCaseService.stableDiffusionService.cancelPolling()
                }
            }, receiveValue: { [weak self] response in
                // 이미지 응답 처리
                if let base64 = response.images.first,
                   let image = base64.toUIImageFromBase64() {
                    self?.generatedImage = image
                    print("이미지 생성 완료")
                } else {
                    print("이미지 디코딩 실패")
                }
                
                self?.container.useCaseService.stableDiffusionService.cancelPolling()
            })
            .store(in: &cancellables)
    }

    /// 이미지 생성 진행률 폴링
    private func pollProgress() {
        container.useCaseService.stableDiffusionService.pollProgress()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.isGenerating = false
            }, receiveValue: { [weak self] response in
                let percent = response.progress * 100
                self?.progressPercentage = percent
            })
            .store(in: &cancellables)
    }
}
