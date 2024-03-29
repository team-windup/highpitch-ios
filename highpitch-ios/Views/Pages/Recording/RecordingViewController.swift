//
//  RecordingViewController.swift
//  highpitch-ios
//
//  Created by yuncoffee on 2/21/24.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

enum PracticeSaveType: Int {
    case makeNew
    case previous
}

class RecordingViewController: UIViewController {
    // swiftlint: disable force_cast
    private var mainView: RecordingView {
        view as! RecordingView
    }
    // swiftlint: enable force_cast
    
    private let sheetVC = UINavigationController(rootViewController: SheetViewController())
    private let alertVC = UIAlertController(title: "프로젝트 저장",
                                            message: "저장할 프로젝트의 제목을 설정해주세요",
                                            preferredStyle: .alert)
    private let sendRecordingResultVC = SendRecordingResultViewController()
    
    private let vm = RecordingViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    private func setup() {
        setupNavigationBar()
        setupAlert()
        setupSheetView()
    }
    
    private func setupNavigationBar() {
        let finishPracticeAction = UIAction { [weak self] _ in
            guard let self = self else { return }
            present(alertVC, animated: true)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "연습 끝내기",
                                                            image: nil,
                                                            primaryAction: finishPracticeAction)
    }
    
    private func setupAlert() {
        alertVC.addTextField { [weak self] textField in
            guard let self = self else { return }
            textField.placeholder = vm.projectName.value
            textField.text = vm.projectName.value
        }
        alertVC.addAction(.init(title: "기존 프로젝트에 저장",
                                style: .default,
                                handler: { [weak self] _ in
            guard let self = self else { return }
            save(as: .previous)
            
        }))
        alertVC.addAction(.init(title: "저장",
                                style: .default,
                                handler: { [weak self] _ in
            guard let self = self else { return }
            save(as: .makeNew)
        }))
        alertVC.addAction(UIAlertAction(title: "취소", style: .cancel))
    }
    
    private func setupSheetView() {
        sheetVC.modalPresentationStyle = .pageSheet
        let vc = sheetVC.viewControllers.first as? SheetViewController
        
        vc?.dismissAction = { [weak self] index in
            guard let self = self else {return}
            if index == 1 {
                dismiss(animated: true)
                present(sendRecordingResultVC, animated: true)
            } else {
                present(alertVC, animated: true)
            }
        }
    }
    
    private func bind() {
        vm.projectName
            .asDriver()
            .drive { [weak self] value in
                self?.mainView.outputLabel.text = value
                self?.mainView.setNeedsLayout()
            }
            .disposed(by: disposeBag)
        
        alertVC.textFields?.first?.rx.text.orEmpty
            .bind(to: vm.projectName)
            .disposed(by: disposeBag)
    }
    
    override func loadView() {
        view = RecordingView()
    }
    private func save(as type: PracticeSaveType) {
        switch type {
        case .makeNew:
            present(sendRecordingResultVC, animated: true)
        case .previous:
            if let sheet = sheetVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            present(sheetVC, animated: true)
        }
    }
}

struct RecordingViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: RecordingViewController())
        }
    }
}
