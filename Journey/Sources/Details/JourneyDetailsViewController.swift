//
//  JourneyDetailsViewController.swift
//  Journey
//
//  Created by Mariusz Sut on 16/11/2021.
//

import RxSwift
import RxCocoa
import UIKit
import Core

final class JourneyDetailsViewController: UIViewController {
    private lazy var tagView = TagView(layout: layoutFactory.tagView(itemSpacing: Spacings.normal))
    private lazy var disposeBag = DisposeBag()
    var viewModel: JourneyDetailsViewModel!
    var layoutFactory: CompositionalLayoutFactoryProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }

    private func bindViewModel() {
        let loadTrigger = rx.methodInvoked(#selector(viewWillAppear))
            .mapToVoid()
            .asDriver()
        
        let output = viewModel.transform(input: .init(load: loadTrigger))
        
        output.journeyName
            .drive(rx.title)
            .disposed(by: disposeBag)
        
        output.participants
            .drive(tagView.rx.items)
            .disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.addSubview(tagView)
        view.backgroundColor = Assets.Colors.Core.Background.primary
        tagView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
