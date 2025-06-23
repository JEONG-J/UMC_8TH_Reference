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

final class OCRManager {
    func recognizeReceipt(image: UIImage) async throws -> ReceiptModel? {
        let text = try await recognizeText(image: image)
        return parseReceipt(text: text)
    }
    
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
                
                guard let results = request.results as? [VNRecognizedTextObservation] else {
                    continuation.resume(returning: "")
                    return
                }
                
                let recognizedStrings = results.compactMap { $0.topCandidates(1).first?.string }
                let fullText = recognizedStrings.joined(separator: "\n")
                continuation.resume(returning: fullText)
            }
            
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true
            request.recognitionLanguages = ["ko-KR", "en-US"]
            
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    try handler.perform([request])
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func parseReceipt(text: String) -> ReceiptModel? {
        let lines = text.components(separatedBy: .newlines)
        
        var store = "매장 정보 없음"
        var totalAmount = 0
        var date: Date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        
        for (index, line) in lines.enumerated() {
            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if store == "매장 정보 없음", trimmed.contains("점") {
                store = "스타벅스 " + trimmed
            }
            
            if trimmed.contains("결제금액"), index + 2 < lines.count {
                let nextLine = lines[index + 2].trimmingCharacters(in: .whitespaces)
                let numberOnly = nextLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let amount = Int(numberOnly) {
                    totalAmount = amount
                }
            }
            
            if let parsedDate = parseDate(string: trimmed) {
                print("날짜 데이터 추출: \(parsedDate)")
                date = parsedDate
            }
        }
        
        return ReceiptModel(
            id: UUID(),
            stroeName: store,
            date: date,
            price: totalAmount,
            createdAt: Date()
        )
    }
    
    func parseDate(string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")

        var cleaned = string.trimmingCharacters(in: .whitespacesAndNewlines)

        /* 날짜와 사간이 붙어 있는경우로 OCR 추출되기 때문에 정규식 문자로 분리해서 가공 */
        /* 아래 정규식 문자의 표현은 아래 주석과 같은 순서로 분리합니다. */
        /* 연도측정 - 월 측정 - 일 측정 \ 시간 측정 : 분 측정 : 초 측정 */
        if cleaned.range(of: #"^\d{4}-\d{2}-\d{2}\d{2}:\d{2}:\d{2}$"#, options: .regularExpression) != nil {
            let datePart = String(cleaned.prefix(10)) // 년-월-일 10자리
            let timePart = String(cleaned.suffix(8)) // 시간:분:초 8자리
            cleaned = "\(datePart) \(timePart)"
        }

        let formats = [
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd HH:mm",
            "yyyy.MM.dd HH:mm",
            "yyyy/MM/dd HH:mm"
        ]

        for format in formats {
            formatter.dateFormat = format
            if let date = formatter.date(from: cleaned) {
                return date
            }
        }
        return nil
    }
}
