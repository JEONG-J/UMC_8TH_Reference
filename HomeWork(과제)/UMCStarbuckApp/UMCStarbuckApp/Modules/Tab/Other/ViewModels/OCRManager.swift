//
//  OCRManager.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/23/25.
//

import Foundation
import UIKit
import SwiftData
@preconcurrency import Vision

/// OCR 기능을 통해 영수증 이미지를 분석하고 필요한 정보를 추출하는 매니저
final class OCRManager {
    
    /// 외부에서 호출하는 메서드: 이미지로부터 텍스트를 인식하고 ReceiptModel로 파싱
    func recognizeReceipt(image: UIImage) async throws -> ReceiptModel? {
        let text = try await recognizeText(image: image)      // OCR 텍스트 인식
        return parseReceipt(text: text)                        // 텍스트에서 정보 추출
    }
    
    /// Vision 프레임워크를 사용하여 이미지에서 텍스트 추출
    private func recognizeText(image: UIImage) async throws -> String {
        guard let cgImage = image.cgImage else {
            throw NSError(domain: "OCRManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "CG 이미지 변환 실패"])
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            let request = VNRecognizeTextRequest { request, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                
                // OCR 결과 추출
                guard let results = request.results as? [VNRecognizedTextObservation] else {
                    continuation.resume(returning: "")
                    return
                }
                
                // 가장 높은 인식률의 문자열만 추출하여 하나의 문자열로 합침
                let recognizedStrings = results.compactMap { $0.topCandidates(1).first?.string }
                let fullText = recognizedStrings.joined(separator: "\n")
                continuation.resume(returning: fullText)
            }
            
            // 텍스트 인식 세부 설정
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true
            request.recognitionLanguages = ["ko-KR", "en-US"]
            
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            
            // 별도의 쓰레드에서 OCR 처리
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// OCR 결과 텍스트에서 매장명, 결제 금액, 날짜 등을 파싱하여 ReceiptModel 생성
    private func parseReceipt(text: String) -> ReceiptModel? {
        let lines = text.components(separatedBy: .newlines)
        
        var store = "매장 정보 없음"
        var totalAmount = 0
        var date: Date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        
        for (index, line) in lines.enumerated() {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // 매장명 추출 (예: "강남점", "홍대점")
            if store == "매장 정보 없음", trimmed.contains("점") {
                store = "스타벅스 " + trimmed
            }
            
            // 결제 금액 추출 (예: "결제금액" 다음 줄에서 숫자 찾기)
            if trimmed.contains("결제금액"), index + 2 < lines.count {
                let nextLine = lines[index + 2].trimmingCharacters(in: .whitespaces)
                let numberOnly = nextLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let amount = Int(numberOnly) {
                    totalAmount = amount
                }
            }
            
            // 날짜 추출 시도
            if let parsedDate = parseDate(string: trimmed) {
                print("날짜 데이터 추출: \(parsedDate)")
                date = parsedDate
            }
        }
        
        // ReceiptModel 반환
        return ReceiptModel(
            id: UUID(),
            stroeName: store,
            date: date,
            price: totalAmount,
            createdAt: Date()
        )
    }
    
    /// OCR 텍스트에서 날짜 문자열을 다양한 형식으로 파싱
    func parseDate(string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")

        var cleaned = string.trimmingCharacters(in: .whitespacesAndNewlines)

        // 날짜와 시간이 붙어있는 경우 (ex. "2025-07-01 130205")를 분리
        if cleaned.range(of: #"^\d{4}-\d{2}-\d{2}\d{2}:\d{2}:\d{2}$"#, options: .regularExpression) != nil {
            let datePart = String(cleaned.prefix(10)) // "yyyy-MM-dd"
            let timePart = String(cleaned.suffix(8))  // "HH:mm:ss"
            cleaned = "\(datePart) \(timePart)"
        }

        // 다양한 날짜 포맷 후보군
        let formats = [
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd HH:mm",
            "yyyy.MM.dd HH:mm",
            "yyyy/MM/dd HH:mm"
        ]

        // 포맷을 순회하며 날짜 파싱 시도
        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: cleaned) {
                return date
            }
        }
        return nil
    }
}
