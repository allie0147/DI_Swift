//
//  CoursesUIViewController.swift
//  MyAppUIKit
//
//  Created by Allie Kim on 2021/09/07.
//

import UIKit

/// APICaller의 function과 연결하기 위해서 만듬: ViewController에서 extension으로 사용
public protocol DataFetchable {
    func fetchCourseNames(completion: @escaping([String]) -> Void)
}

/// Model
struct Course {
    let name: String
}

public class CoursesViewController: UIViewController {

    let dataFetchable: DataFetchable

    var courses: [Course] = []

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    // ViewController에 inject
    public init(dataFetchable: DataFetchable) {
        self.dataFetchable = dataFetchable
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        dataFetchable.fetchCourseNames { [weak self] names in
            self?.courses = names.map { Course(name: $0) }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 20, width: view.bounds.width, height: view.bounds.height)
    }
}
// MARK: -Extension: UITableViewDelegate, UITableViewDataSource
extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }

}
