//
//  ReceiptsViewModel.swift
//  4st_Practice
//
//  Created by Apple Coding machine on 4/1/25.
//

import SwiftUI
import Vision

@Observable
class ReceiptsViewModel {
    var selectedSegment: ReceiptSegment = .first {
        didSet {
            startOCR(selectedSegment)
        }
    }

    var currentReceipt: ReceiptsModel?

    func startOCR(_ segment: ReceiptSegment) {
        guard let uiImage = UIImage(named: segment.imageName),
              let cgImage = uiImage.cgImage else {
            self.currentReceipt = nil
            return
        }

        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self,
                  let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                self?.currentReceipt = nil
                return
            }

            let recognizedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
            let fullText = recognizedStrings.joined(separator: "\n")
            let parsed = self.parseWithoutRegex(from: fullText)

            DispatchQueue.main.async {
                self.currentReceipt = parsed
            }
        }

        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform([request])
        }
    }

    private func parseWithoutRegex(from text: String) -> ReceiptsModel {
        let lines = text.components(separatedBy: .newlines)

        var orderer = "주문자 없음"
        var store = "장소 없음"
        var menuItems: [String] = []
        var totalAmount = 0
        var orderNumber = "주문번호 없음"

        var isMenuSection = false
        var i = 0

        print("===== OCR 디버그 시작 =====")

        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
            print("🔹 [\(i)] \(trimmed)")

            // 주문자
            if trimmed.range(of: #"\([A-Z]-\s*\d+\)"#, options: .regularExpression) != nil {
                orderer = trimmed.components(separatedBy: " ").first ?? "주문자 없음"
                isMenuSection = true
                i += 1
                continue
            }

            // 장소
            if store == "장소 없음", trimmed.contains("점") {
                store = "스타벅스 " + trimmed
            }

            // 결제 금액
            if trimmed.contains("결제금액"), i + 2 < lines.count {
                let priceLine = lines[i + 2].trimmingCharacters(in: .whitespaces)
                let numberOnly = priceLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let amount = Int(numberOnly) {
                    totalAmount = amount
                }
            }

            // 주문번호
            if trimmed.starts(with: "32"),
               trimmed.count >= 14,
               trimmed.allSatisfy({ $0.isNumber }) {
                orderNumber = trimmed
            }

            // 메뉴 종료
            if trimmed.contains("합계") || trimmed.contains("결제금액") {
                isMenuSection = false
            }

            // 메뉴 인식: T 포함 줄
            if isMenuSection,
               trimmed.contains("T"),
               !trimmed.hasPrefix("L"),
               !trimmed.contains("할인"),
               !trimmed.contains("데움") {
                
                let cleanName = trimmed.components(separatedBy: ")").last?.trimmingCharacters(in: .whitespaces) ?? trimmed
                menuItems.append(cleanName)
            }

            i += 1
        }

        print("===== OCR 디버그 끝 =====")
        print("👤 주문자: \(orderer)")
        print("🏪 매장명: \(store)")
        print("☕️ 주문 음료: \(menuItems)")
        print("💰 결제 금액: \(totalAmount)")
        print("🧾 주문번호: \(orderNumber)")

        return ReceiptsModel(
            orderer: orderer,
            store: store,
            menuItems: menuItems,
            totalAmount: totalAmount,
            orderNumber: orderNumber
        )
    }
}
