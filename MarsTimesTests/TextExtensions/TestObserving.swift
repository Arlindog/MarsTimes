//
//  TestObserving.swift
//  MarsTimesTests
//
//  Created by Arlindo on 9/4/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import RxSwift
import RxCocoa
import RxTest

protocol TestObserving {
    var disposeBag: DisposeBag { get }
    var scheduler: TestScheduler { get }
}

extension TestObserving {
    func observe<Type: ObservableType, Element>(_ observable: Type) -> TestableObserver<Element> where Type.Element == Element {
        let testObserver = scheduler.createObserver(Element.self)
        observable
            .subscribe(testObserver)
            .disposed(by: disposeBag)
        return testObserver
    }
}
