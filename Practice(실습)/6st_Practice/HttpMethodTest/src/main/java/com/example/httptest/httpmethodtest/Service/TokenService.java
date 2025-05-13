package com.example.httptest.httpmethodtest.Service;

import com.example.httptest.httpmethodtest.DTO.TokenResponse;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class TokenService {

    // 고정된 RefreshToken 값
    private final String staticRefreshToken = "umc_refresh_token";

    // AccessToken 유효 기간 (1분)
    private final long accessTokenValidDuration = 60 * 1000;

    // AccessToken과 그 만료 시간을 저장할 Map
    private final Map<String, Long> accessTokenMap = new HashMap<>();

    /**
     * AccessToken을 생성하고, 만료 시간과 함께 저장한 후 반환
     * 이 메서드는 실제로는 "AccessToken 생성" 용도로 사용되며,
     * staticRefreshToken 자체는 리턴하지 않음
     */
    public String getStaticRefreshToken() {
        String accessToken = UUID.randomUUID().toString(); // 고유한 AccessToken 생성
        accessTokenMap.put(accessToken, System.currentTimeMillis() + accessTokenValidDuration); // 유효 시간 설정
        return accessToken;
    }

    /**
     * 주어진 AccessToken이 아직 유효한지 확인
     * 만료되지 않았으면 true 반환
     */
    public boolean isAccessTokenExpired(String token) {
        Long expiryTime = accessTokenMap.get(token);
        return expiryTime != null && expiryTime > System.currentTimeMillis();
    }

    /**
     * 고정된 RefreshToken과 입력된 값이 일치하는지 확인
     * RefreshToken은 만료 시간이 아니라, 고정 문자열 비교로 유효성 판단
     */
    public boolean isRefreshTokenExpired(String refreshToken) {
        return staticRefreshToken.equals(refreshToken);
    }

    /**
     * 새로운 AccessToken과 고정된 RefreshToken을 함께 반환하는 메서드
     */
    public TokenResponse issueToken() {
        String newAccessToken = getStaticRefreshToken(); // 새로운 accessToken 생성
        return new TokenResponse(newAccessToken, staticRefreshToken); // 둘 다 응답
    }
}