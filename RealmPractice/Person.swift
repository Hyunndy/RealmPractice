//
//  Person.swift
//  RealmPractice
//
//  Created by 유현지 on 2023/01/25.
//

import Foundation
import RealmSwift

/*
 객체 모델로 사용할 클래스
 
 - @objc dynamic:
 
    - 이 키워드가 붙은 변수는 변수의 값이 바뀔 때 마다 Realm에 알리고 DB에 알려주는 기능을 합니다.
        Create, Read, Update, Delete 등 파일에 쓰는 작업은 realm의 권한으로 접근해야합니다.
        realm.write { "내용" }
 
    - 정의:
        @objc + dynamic이 사용되는 이유는 Swift - Object-C와의 상호운용성 때문이다.
        Object-C는 런타임에 호출 될 특정 메서드나 프로퍼티를 해당 객체에 "메세지"를 보내는 방식으로 구현되어있다.
        Swift 컴파일러는 이 동적 디스패치를 안하고 정적 디스패치를 하는데, UserDefaults, 키-밸류 옵저빙과 같은것들은 Object-C 런타임으로 해야한다고 한다.
 
 

 
 
 */
class Person: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var age: Int = 0
    @objc dynamic var name: String = ""
    
    //id를 프라이머리 키로 지정
    override static func primaryKey() -> String? {
        return "id"
    }
}
