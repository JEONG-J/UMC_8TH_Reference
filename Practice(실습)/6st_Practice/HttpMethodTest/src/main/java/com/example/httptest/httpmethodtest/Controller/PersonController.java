package com.example.httptest.httpmethodtest.Controller;

import com.example.httptest.httpmethodtest.DTO.Person;
import com.example.httptest.httpmethodtest.Service.TokenService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.concurrent.atomic.AtomicReference;

@RestController
@RequestMapping("/person")
public class PersonController {

    private final AtomicReference<Person> personStorage = new AtomicReference<>();
    private final TokenService tokenService;

    public PersonController(TokenService tokenService) {
        this.tokenService = tokenService;
    }

    /**
     * Authorization 헤더에서 Bearer 토큰을 추출하고 유효성 검사
     */
    private void validateAccessToken(String authorizationHeader) {
        if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "AccessToken이 존재하지 않거나 형식이 잘못되었습니다.");
        }
        String token = authorizationHeader.substring(7);
        if (!tokenService.isAccessTokenExpired(token)) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "AccessToken이 만료되었거나 유효하지 않습니다.");
        }
    }

    @PostMapping
    public String createPerson(@RequestBody Person person,
                               @RequestHeader(value = "Authorization", required = false) String authorization) {
        validateAccessToken(authorization);
        personStorage.set(person);
        return "사람 생성 완료";
    }

    @GetMapping
    public Person getPerson(@RequestParam String name,
                            @RequestHeader(value = "Authorization", required = false) String authorization) {
        validateAccessToken(authorization);

        Person person = personStorage.get();
        if (person == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "등록된 사람 없음");
        }
        if (!person.getName().equals(name)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "해당 이름의 사람 없음");
        }
        return person;
    }

    @PutMapping
    public String updatePerson(@RequestBody Person updatePerson,
                               @RequestHeader(value = "Authorization", required = false) String authorization) {
        validateAccessToken(authorization);
        personStorage.set(updatePerson);
        return "사람 정보 업데이트";
    }

    @PatchMapping
    public String patchPerson(@RequestBody Person partialPerson,
                              @RequestHeader(value = "Authorization", required = false) String authorization) {
        validateAccessToken(authorization);

        Person currentPerson = personStorage.get();
        if (currentPerson == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "등록된 사람 없음");
        }

        // 필드별 null 확인
        if (partialPerson.getName() != null) currentPerson.setName(partialPerson.getName());
        if (partialPerson.getAge() > 0) currentPerson.setAge(partialPerson.getAge());
        if (partialPerson.getAddress() != null) currentPerson.setAddress(partialPerson.getAddress());
        if (partialPerson.getHeight() > 0) currentPerson.setHeight(partialPerson.getHeight());

        personStorage.set(currentPerson);
        return "사람 부분 정보 수정 완료";
    }

    @DeleteMapping
    public String deletePerson(@RequestParam String name,
                               @RequestHeader(value = "Authorization", required = false) String authorization) {
        validateAccessToken(authorization);

        Person person = personStorage.get();
        if (person == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "등록된 사람 없음");
        }
        if (!person.getName().equals(name)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "이름 같은 사람 없음");
        }

        personStorage.set(null);
        return "등록된 사람 삭제 완료";
    }
}