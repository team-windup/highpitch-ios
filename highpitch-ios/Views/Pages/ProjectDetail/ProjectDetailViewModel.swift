//
//  ProjectDetailViewModel.swift
//  highpitch-ios
//
//  Created by yuncoffee on 3/5/24.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class ProjectDetailViewModel: ViewModelType {
    let sections = BehaviorRelay(value: [SectionOfPracticeModel]())
    let currentTabRelay = BehaviorRelay(value: ProjectDetailViewTabs.summary)
    let disposeBag = DisposeBag()
    
    struct Input {
        let selectedSegmentedControl: ControlProperty<Int>
    }
    
    struct Output {
        let selectedSegmentedControl: BehaviorRelay<ProjectDetailViewTabs>
    }
    
    func transform(input: Input) -> Output {
        input.selectedSegmentedControl
            .map {ProjectDetailViewTabs(rawValue: $0)!}
            .bind(to: currentTabRelay)
            .disposed(by: disposeBag)
        
        return Output(selectedSegmentedControl: currentTabRelay)
    }
}

enum ProjectDetailViewTabs: Int {
    case summary
    case practices
}
