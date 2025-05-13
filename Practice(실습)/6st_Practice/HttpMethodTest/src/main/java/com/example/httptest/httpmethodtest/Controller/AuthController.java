package com.example.httptest.httpmethodtest.Controller;

import com.example.httptest.httpmethodtest.DTO.TokenResponse;
import com.example.httptest.httpmethodtest.Service.TokenService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

@RestController
@RequestMapping("/auth")
public class AuthController {

    private final TokenService tokenService;

    public AuthController(TokenService tokenService) {
        this.tokenService = tokenService;
    }

    /**
     * 최초 로그인 시 토큰 발급
     * 실제 인증 없이 AccessToken과 고정 RefreshToken을 발급
     */
    @GetMapping("/login")
    public TokenResponse login() {
        return tokenService.issueToken();
    }

    /**
     * 클라이언트가 만료된 AccessToken을 새로 발급받기 위한 Refresh 요청
     * 고정된 RefreshToken과 일치할 경우에만 새로운 AccessToken 발급
     */
    @GetMapping("/refresh")
    public TokenResponse refresh(@RequestParam String refreshToken) {
        if (!tokenService.isRefreshTokenExpired(refreshToken)) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "유효하지 않은 RefreshToken입니다.");
        }
        return tokenService.issueToken();
    }
}