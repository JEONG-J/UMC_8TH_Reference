//
//  DiffusionDTO.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 7/3/25.
//

import Foundation

struct Txt2ImgRequest: Codable {
    let prompt: String
    let negative_prompt: String
    let styles: [String]
    let seed: Int
    let subseed: Int
    let subseed_strength: Double
    let seed_resize_from_h: Int
    let seed_resize_from_w: Int
    let sampler_name: String
    let scheduler: String
    let batch_size: Int
    let n_iter: Int
    let steps: Int
    let cfg_scale: Double
    let width: Int
    let height: Int
    let restore_faces: Bool
    let tiling: Bool
    let do_not_save_samples: Bool
    let do_not_save_grid: Bool
    let eta: Double
    let denoising_strength: Double
    let s_min_uncond: Double
    let s_churn: Double
    let s_tmax: Double
    let s_tmin: Double
    let s_noise: Double
    let override_settings: [String: String]
    let override_settings_restore_afterwards: Bool
    let refiner_checkpoint: String
    let refiner_switch_at: Double
    let disable_extra_networks: Bool
    let firstpass_image: String?
    let comments: [String: String]
    let enable_hr: Bool
    let firstphase_width: Int
    let firstphase_height: Int
    let hr_scale: Double
    let hr_upscaler: String
    let hr_second_pass_steps: Int
    let hr_resize_x: Int
    let hr_resize_y: Int
    let hr_checkpoint_name: String
    let hr_sampler_name: String
    let hr_scheduler: String
    let hr_prompt: String
    let hr_negative_prompt: String
    let force_task_id: String
    let sampler_index: String
    let script_name: String
    let script_args: [String]
    let send_images: Bool
    let save_images: Bool
    let alwayson_scripts: [String: String]
    let infotext: String
}

struct Txt2ImgImageOnlyResponse: Codable {
    let images: [String]
}

extension Txt2ImgRequest {
    init() {
        self.prompt = "a single stylish Starbucks gift card, isolated, no background, transparent background, centered, elegant minimal layout, green and white theme, modern typography, realistic 3D render, sharp edges, floating appearance"
        self.negative_prompt = "blurry, low quality, distorted, poorly drawn, extra objects, hands, fingers, multiple cards, background clutter, text artifacts, watermark, pixelated, oversaturated, reflections, busy background"
        self.styles = []
        self.seed = -1
        self.subseed = -1
        self.subseed_strength = 0
        self.seed_resize_from_h = -1
        self.seed_resize_from_w = -1
        self.sampler_name = "DPM++ 2M"
        self.scheduler = ""
        self.batch_size = 1
        self.n_iter = 1
        self.steps = 40
        self.cfg_scale = 7.5
        self.width = 640
        self.height = 640
        self.restore_faces = true
        self.tiling = false
        self.do_not_save_samples = false
        self.do_not_save_grid = false
        self.eta = 0
        self.denoising_strength = 0
        self.s_min_uncond = 0
        self.s_churn = 0
        self.s_tmax = 0
        self.s_tmin = 0
        self.s_noise = 0
        self.override_settings = [:]
        self.override_settings_restore_afterwards = true
        self.refiner_checkpoint = ""
        self.refiner_switch_at = 0.85
        self.disable_extra_networks = false
        self.firstpass_image = nil
        self.comments = [:]
        self.enable_hr = false
        self.firstphase_width = 0
        self.firstphase_height = 0
        self.hr_scale = 0
        self.hr_upscaler = ""
        self.hr_second_pass_steps = 0
        self.hr_resize_x = 0
        self.hr_resize_y = 0
        self.hr_checkpoint_name = ""
        self.hr_sampler_name = "DPM++ 2M"
        self.hr_scheduler = ""
        self.hr_prompt = ""
        self.hr_negative_prompt = ""
        self.force_task_id = ""
        self.sampler_index = "DPM++ 2M"
        self.script_name = ""
        self.script_args = []
        self.send_images = true
        self.save_images = false
        self.alwayson_scripts = [:]
        self.infotext = ""
    }
}

