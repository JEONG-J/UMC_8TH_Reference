//
//  StableDiffusionService.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/3/25.
//

import Foundation
import CombineMoya
import Moya
import Combine

/// Stable Diffusion 이미지 생성 및 진행률 확인을 위한 서비스 프로토콜
protocol StableDiffusionServiceProtocol {
    /// 텍스트 기반 이미지 생성 요청
    func gernerateImage(request: Txt2ImgRequest) -> AnyPublisher<Txt2ImgImageOnlyResponse, StableDiffusionError>
    
    /// 이미지 생성 진행률을 폴링(polling) 방식으로 조회
    func pollProgress(interval: TimeInterval) -> AnyPublisher<ProgressResponse, Never>
    
    /// 폴링 취소
    func cancelPolling()
}

/// Stable Diffusion API를 사용하여 이미지 생성을 처리하는 서비스
final class StableDiffusionService: StableDiffusionServiceProtocol {
    
    /// MoyaProvider를 통해 API 요청을 전송
    let provider: MoyaProvider<StableDiffusionRouter>
    
    /// 진행률 폴링을 위한 구독 관리용
    private var pollingCancellable: AnyCancellable?
    
    /// 타이머 연결 관리용
    private var timerConnection: Combine.Cancellable?
    
    // MARK: - Initializer
    
    /// 초기화 시 세션 타임아웃 설정 및 MoyaProvider 구성
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 180
        configuration.timeoutIntervalForResource = 180
        
        let session = Session(configuration: configuration)
        
        self.provider = MoyaProvider<StableDiffusionRouter>(
            session: session,
            plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
        )
    }
    
    // MARK: - 이미지 생성
    
    /// 텍스트 기반 이미지 생성 요청
    /// - Parameter request: 텍스트 → 이미지 요청 모델
    /// - Returns: 이미지 Base64 응답을 Combine Publisher 형태로 반환
    func gernerateImage(request: Txt2ImgRequest) -> AnyPublisher<Txt2ImgImageOnlyResponse, StableDiffusionError> {
        return provider.requestPublisher(.postTextImage(imageData: request))
            .map(Txt2ImgImageOnlyResponse.self)                           // 응답 매핑
            .mapError { StableDiffusionError.moyaError($0) }              // 에러 변환
            .eraseToAnyPublisher()
    }

    // MARK: - 진행률 폴링
    
    /// 이미지 생성 진행률을 폴링 방식으로 주기적으로 요청
    /// - Parameter interval: 폴링 간격 (초) – 기본값 2초
    /// - Returns: 진행률 정보를 담은 Publisher
    func pollProgress(interval: TimeInterval = 2.0) -> AnyPublisher<ProgressResponse, Never> {
        let subject = PassthroughSubject<ProgressResponse, Never>() // 외부에 발행될 Subject
        
        // 타이머 생성 및 연결 저장
        let timerPublisher = Timer.publish(every: interval, on: .main, in: .common)
        self.timerConnection = timerPublisher.connect()
        
        // 타이머가 주기적으로 발행되면 프로그레스 API 호출
        pollingCancellable = timerPublisher
            .flatMap { _ in
                self.provider.requestPublisher(.getProgress(skip: true))
                    .map(ProgressResponse.self)
                    .catch { error -> Empty<ProgressResponse, Never> in
                        print("Progress API 실패: \(error.localizedDescription)")
                        return Empty()
                    }
            }
            .sink(receiveValue: { response in
                subject.send(response)
            })
        
        return subject.eraseToAnyPublisher()
    }

    // MARK: - 폴링 중지
    
    /// 진행률 폴링 요청을 취소하고 메모리 정리
    func cancelPolling() {
        pollingCancellable?.cancel()
        timerConnection?.cancel()
        pollingCancellable = nil
        timerConnection = nil
    }
}
