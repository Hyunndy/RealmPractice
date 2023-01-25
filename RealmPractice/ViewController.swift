//
//  ViewController.swift
//  RealmPractice
//
//  Created by 유현지 on 2023/01/25.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var realm: Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.getRealm()
//        self.saveRelamData()
//        self.readRealmData()
        
//        self.updateRealmData()
        
//        self.removeRealmData()
//        self.removeRealmFile()
        self.searchRealmData()
    }
    
    private func getRealm() {
        
        // Realm 가져오기
        self.realm = try! Realm()
        
        /*
         Realm 파일 위치
         커맨드 + 쉬프트 + G로 경로 열고 여기서 나오는 default Realm을 열면 Person 클래스가 나온다.
         근데 어떻게 Person 클래스를 지정하지도 않았느데 나오는거지?
         */
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }

    // Realm에 저장할 데이터 생성
    private func saveRelamData() {
        
        let person = Person()
        person.name = "철수"
        person.age = 10
        person.id = 1
        
        let person2 = Person()
        person2.name = "영희"
        person2.age = 20
        person2.id = 2
        
        // Realm에 저장하기!
        try! self.realm.write {
            self.realm.add(person)
            self.realm.add(person2)
        }
    }
    
    // Relam에 있는 데이터 가져오기
    private func readRealmData() {
        
        /*
         통으로 가져오기!
         
         Results<Person> <0x145e06c70> (
         [0] Person {
         id = 1;
         age = 10;
         name = 철수;
         },
         [1] Person {
         id = 2;
         age = 20;
         name = 영희;
         }
         )
         */
        let savedPerson = self.realm.objects(Person.self)
        print(savedPerson)
        
        // 가져온 오브젝트로 필터링해보기 - id
        /*
         id가 1인사람 - Results<Person> <0x12fe0f770> (
             [0] Person {
                 id = 1;
                 age = 10;
                 name = 철수;
             }
         )
         */
        let filteredPerson = savedPerson.filter("id == 1")
        print("id가 1인사람 - \(filteredPerson)")
        
        // 가져온 오브젝트로 필터링해보기 - name
        // String 비교는 따옴표 붙어야 되는거 주의
        /*
         이름이 영희인사람 - Results<Person> <0x12fe10130> (
             [0] Person {
                 id = 2;
                 age = 20;
                 name = 영희;
             }
         )
         */
        let filteredPerson2 = savedPerson.filter("name == '영희'")
        print("이름이 영희인사람 - \(filteredPerson2)")
        
        // 가져온 오브젝트로 필터링해보기 - 나이
        /*
         나이가 20 이하인 사람 - Results<Person> <0x12fe11690> (
             [0] Person {
                 id = 1;
                 age = 10;
                 name = 철수;
             },
             [1] Person {
                 id = 2;
                 age = 20;
                 name = 영희;
             }
         )
         */
        let filteredPerson3 = savedPerson.filter("age <= 20")
        print("나이가 20 이하인 사람 - \(filteredPerson3)")
        
        // 갯수확인
        /*
         나이가 20 이하인 사람 몇 명? - 2
         */
        print("나이가 20 이하인 사람 몇 명? - \(filteredPerson3.count)")
    }
    
    // 값 업데이트
    private func updateRealmData() {
        
        let savedPerson = self.realm.objects(Person.self)
        let id1Person = savedPerson.filter("id == 1")
        
        try! realm.write {
            id1Person[0].name = "김태훈"
        }
        
        print(savedPerson)
    }
    
    // 값 삭제!
    private func removeRealmData() {
        
        let savedPerson = self.realm.objects(Person.self)
        let youngHui = savedPerson.filter("name == '영희'")
        
        try! realm.write {
            savedPerson.realm?.delete(youngHui)
        }
        
        print(savedPerson)
    }
    
    // Realm 파일 자체 삭제
    private func removeRealmFile() {
        
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                
            }
        }
    }
    
    private func searchRealmData() {
        
        let savedPerson = self.realm.objects(Person.self)
        
        let myFilter = NSPredicate(format: "name == '철수'")
        print(savedPerson.filter(myFilter).first)
        
        let myFilter2 = NSPredicate(format: "age > 15")
        print(savedPerson.filter(myFilter2).first)
    }
}

