//
//  TestModel.swift
//  MethodSwizzling
//
//  Created by 刘喆 on 2022-03-04.
//

import Foundation

/*
 Method swizzling是在运行时改变现有selector的实现的过程，简单来说就是在运行的时候改变一个方法的功能
 */
class TestModel: ObservableObject {
    //属性和方法必须用dynamic标记，使它在
    dynamic var a: Int = 0
    dynamic var b: Double = 1.2
    dynamic func hello(){
        print("hello world")
    }
}

extension TestModel {
    //@_dynamicReplacement是Swift 5新出的
    //https://github.com/apple/swift/blob/7123d2614b5f222d03b3762cb110d27a9dd98e24/test/attr/dynamicReplacement.swift
    @_dynamicReplacement(for: hello())
    func goodbye(){
        print(a)
    }
    
    @_dynamicReplacement(for: a)
    var x: Int { return 11 }
}


/*
 Swift 5之前的方法，跟Objective-C中使用方法一样，只是语言用的Swift.
 @objc修饰符可以把属性、类、方法、协议暴露给objective-c runtime。
 没有上面的方法好用，不继续研究了
 */
class TestModel_Legacy: NSObject, ObservableObject {
    @objc dynamic var a: Int = 0
    @objc dynamic var b: Double = 1.01
    override init() {
        TestModel_Legacy.swizzle()
    }
    @objc dynamic func hello() {
        print("hello world")
    }
}
extension TestModel_Legacy {
    static func swizzle() {
        let originSelector = #selector(TestModel_Legacy.hello)
        let swizzleSelector = #selector(TestModel_Legacy.goodbye)
        let originMethod = class_getInstanceMethod(TestModel_Legacy.self, originSelector)
        let swizzleMethod = class_getInstanceMethod(TestModel_Legacy.self, swizzleSelector)
        method_exchangeImplementations(originMethod!, swizzleMethod!)
        
    }
    @objc func goodbye() {
        print("goodbye")
    }
}
