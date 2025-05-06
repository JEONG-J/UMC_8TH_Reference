//
//  BarcodeScanner.swift
//  6st_Practice
//
//  Created by Apple Coding machine on 5/4/25.
//

import Foundation
import AVFoundation
import SwiftUI

// 바코드 스캐너를 SwiftUI에서 사용하기 위한 UIViewControllerRepresentable 구조체
struct BarcodeScannerView: UIViewControllerRepresentable {
    
    // Coordinator 클래스: AVCaptureMetadataOutputObjectsDelegate 채택
    // 바코드를 인식했을 때 호출되는 델리게이트를 담당
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: BarcodeScannerView
        
        init(parent: BarcodeScannerView) {
            self.parent = parent
        }
        
        // 바코드를 인식했을 때 호출되는 메서드
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                // 바코드 데이터를 문자열로 변환
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }

                // 진동을 울려 사용자에게 인식되었음을 알림
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                // ISBN 값에서 하이픈(-) 제거
                let cleanedISBN = stringValue.replacingOccurrences(of: "-", with: "")
                
                // 결과를 상위 뷰로 전달
                parent.didFindCode(cleanedISBN)
            }
        }
    }
    
    // 바코드 인식 결과를 전달받을 클로저
    var didFindCode: (String) -> Void
    
    // Coordinator 인스턴스를 생성
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    // UIViewController 생성 (카메라 + 바코드 스캔 세션 구성)
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()
        
        // 카메라 디바이스 확보
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return viewController }
        let videoInput: AVCaptureDeviceInput
        
        do {
            // 카메라 입력 설정
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            // 에러 발생 시 그냥 기본 컨트롤러 반환
            return viewController
        }
        
        // 세션에 카메라 입력 추가
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return viewController
        }
        
        // 바코드 감지를 위한 메타데이터 출력 설정
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            // 델리게이트 지정 및 지원하는 바코드 타입 설정
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417, .upce]
        } else {
            return viewController
        }
        
        // 카메라 화면을 표시할 미리보기 레이어 구성
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        // 세션 실행 (백그라운드에서 실행 시작)
        DispatchQueue.global(qos: .background).async {
            captureSession.startRunning()
        }
        
        return viewController
    }
    
    // 뷰 업데이트 시 호출 (현재는 필요 없음)
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
