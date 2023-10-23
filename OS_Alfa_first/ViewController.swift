//
//  ViewController.swift
//  OS_Alfa_first
//
//  Created by Нелли Першина on 09.10.2023.
//

import UIKit



    //табла, добавили UITableViewDataSource и нажали фикс дважды
final class ViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BeerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // получаем данные из массива
        let beer = BeerData[indexPath.row]
        var cell = UITableViewCell()
        var configuration = cell.defaultContentConfiguration()
        // configuration.image = UIImage()
        configuration.text = beer.name
        configuration.secondaryText = beer.tagline
        cell.contentConfiguration = configuration
        return cell
    }
    
// создаем табличку, так можно настроить дефолтные значения
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .cyan
        tableView.dataSource = self
        return tableView
    }()
    
    private var BeerData: [BeerDTO] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = . systemPink
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false //старый метод верстки, по умолчанию стоит перевод этой старой штуки в новый способ верстки - констреинты
        // задаем констреинты (ограничения для ViewTable)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        //верстка закончена, можно заполнить табличку данными
        // кто хочет - можно попробовать накатить SnapKit
        
        // если данные приходят не в виде массива, а в виде единственного экземпляра. Можно циклом повызывать эту апи и добавить в массив(это не очень хорошо на реальном проекте, у нас можно, чтобы взять более интересные апи)
        
        let url: URL = URL(string: "https://api.punkapi.com/v2/beers")! // принудительная распаковка используется только в тестах
        URLSession.shared.dataTask(with: url, completionHandler: { data, response,error in
            guard
                let data = data,
                error == nil
            else{
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            // Обработка данных
            self.BeerData = try! decoder.decode([BeerDTO].self, from: data)
            DispatchQueue.main.async(){
                self.tableView.reloadData()
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            // явная многопоточка, для оперирования очередями есть два фреймфорка: низкоуровневый OperationQueue и более вы DispatchQueue
            // многопоточность может быть параллельноц или последовательной, main поточность выполняется всегда последовательно, глобальные очереди по умолчанию параллельны, многопоточка включена по дефолту
        }).resume()
//         клажуры (лямбда функци, completionHandler) - сохранение функций в переменных и передача функции в качестве аргумента. Нужно для того, чтобы не тормозить код, который будет выполняься после отправки запроса на сервер. Он принимает 3 аргумента из самой системы, ничего не возвращает. // с 16 строки
    }
}

struct BeerDTO: Decodable{
    let id: Int
    let name: String
    let tagline: String
    let imageUrl: URL
    // чекнуть информацию про кодинг кейс, что такое camel и snake case
    // сегодня создаем табличку, в которую будем помещать данные
}
