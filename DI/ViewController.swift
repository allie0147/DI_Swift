//
//  ViewController.swift
//  DI
//
//  Created by Allie Kim on 2021/09/07.
//

import UIKit
import APIKit
import MyAppUIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("Tap Me", for: .normal)
        button.center = view.center
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc
    private func didTapButton() {
        let vc = CoursesViewController(dataFetchable: APICaller.shared) // DI 활용
        present(vc, animated: true)
    }
}

extension APICaller: DataFetchable { } // DI 활용
