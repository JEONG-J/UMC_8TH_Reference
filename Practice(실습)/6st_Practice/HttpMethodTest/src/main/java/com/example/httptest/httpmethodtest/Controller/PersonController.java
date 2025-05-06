package com.example.httptest.httpmethodtest.Controller;

import com.example.httptest.httpmethodtest.DTO.Person;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.atomic.AtomicReference;

@RestController
@RequestMapping("/person")
public class PersonController {
    private final  AtomicReference<Person> personStorage = new AtomicReference<>();

    //POST
    @PostMapping
    public String createPerson(@RequestBody Person person) {
        personStorage.set(person);
        return "사람 생성 완료";
    }

    //GET
    @GetMapping
    public Person getPerson(@RequestParam String name) {
        Person person = personStorage.get();
        if (person == null) {
            throw new RuntimeException("등록된 사람 없음");
        }
        /* 쿼리 파라미터를 위한 코드 */
        if (!person.getName().equals(name)) {
            throw new RuntimeException("해당 이름의 사람 없음");
        }
        return  person;
    }

    //PUT : 사람 정보 전체 수정
    //PATCH와 PUT은 다른 개념입니다.
    @PutMapping
    public String updatePerson(@RequestBody Person updatePerson) {
        personStorage.set(updatePerson);
        return  "사람 정보 업데이트";
    }

    // PATCH: 사람 정보 일부 수정
    @PatchMapping
    public String patchPerson(@RequestBody Person partialPerson) {
        Person currentPerson = personStorage.get();
        if (currentPerson == null) {
            throw new RuntimeException("등록된 사람 없음");
        }

        if (partialPerson.getName() != null) {
            currentPerson.setName(partialPerson.getName());
        }
        if (partialPerson.getAge() != 0) {
            currentPerson.setAge(partialPerson.getAge());
        }
        if (partialPerson.getAddress() != null) {
            currentPerson.setAddress(partialPerson.getAddress());
        }
        if (partialPerson.getHeight() != 0.0) {
            currentPerson.setHeight(partialPerson.getHeight());
        }

        personStorage.set(currentPerson);
        return "사람 부분 정보 수정 완료";
    }

    //DELETE
    @DeleteMapping
    public String deletePerson(@RequestParam String name) {
        Person person = personStorage.get();
        if (person == null) {
            throw new RuntimeException("등록된 사람 없음");
        }

        if (!person.getName().equals(name)) {
            throw  new RuntimeException("이름 같은 사람 없음");
        }
        personStorage.set(null);
        return "등록된 사람 삭제 완료";
    }
}
