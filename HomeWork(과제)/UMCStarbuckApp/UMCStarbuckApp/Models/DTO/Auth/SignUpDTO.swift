//
//  SignUpModel.swift
//  UMCStarbuckApp
//
//  Created by Apple Coding machine on 6/19/25.
//

import Foundation

/// 회원가입 요청 시 사용되는 공통 DTO 프로토콜
/// nickname, email, password 값을 갖도록 요구함
protocol SignUpDTO {
    var nickname: String { get set }   // 사용자 닉네임
    var email: String { get set }      // 사용자 이메일
    var password: String { get set }   // 사용자 비밀번호
}

/// 실제 회원가입 요청에 사용될 구조체
/// 서버 API 호출 시 이 타입을 사용해 데이터를 전달함
struct SignUpRequest: SignUpDTO {
    var nickname: String       // 사용자 닉네임
    var email: String          // 사용자 이메일
    var password: String       // 사용자 비밀번호
}
