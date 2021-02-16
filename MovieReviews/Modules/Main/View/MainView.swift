//
//  MainView.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import RxSwift
import UIKit

final class MainView: UIView {
    
    public var segmentedControl: UISegmentedControl?

    // MARK: - Private properties

    private var segmentItems = ["Reviews", "Critics"]
    
    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init() {
        super.init(frame: .zero)
        backgroundColor = .secondarySystemBackground
        setSegmentedControl()
        customizeNavBar(index: 2)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

//    func bind(to viewModel: MainViewModelBindable) {
//        // Bindings UI controls to view model's input/output
//    }
    
    private func setSegmentedControl() {
        self.segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl?.frame = CGRect(x: 40, y: 50, width: 300, height: 30)
        segmentedControl?.selectedSegmentIndex = 0
        segmentedControl!.backgroundColor = Colors.blue
    }
    
    @objc func changeIndex() {
        
    }
    
    private func customizeNavBar(index: Int) {
//        headerLabel.text = segmentedControl.titleForSegment(at: index)
        
//        customNavbar!.backgroundColor = color
    }
}
