//
//  ProgressDTO.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/3/25.
//

import Foundation

import Foundation

struct ProgressResponse: Codable {
    let progress: Double
    let etaRelative: Double
    let state: GenerationState
    let currentImage: String?
    let textinfo: String?
    
    enum CodingKeys: String, CodingKey {
        case progress
        case etaRelative = "eta_relative"
        case state
        case currentImage = "current_image"
        case textinfo
    }
}

struct GenerationState: Codable {
    let skipped: Bool
    let interrupted: Bool
    let stoppingGeneration: Bool
    let job: String
    let jobCount: Int
    let jobTimestamp: String
    let jobNo: Int
    let samplingStep: Int
    let samplingSteps: Int
    
    enum CodingKeys: String, CodingKey {
        case skipped
        case interrupted
        case stoppingGeneration = "stopping_generation"
        case job
        case jobCount = "job_count"
        case jobTimestamp = "job_timestamp"
        case jobNo = "job_no"
        case samplingStep = "sampling_step"
        case samplingSteps = "sampling_steps"
    }
}
