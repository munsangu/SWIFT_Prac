import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var editBTN: UIBarButtonItem!
    var doneBTN: UIBarButtonItem?
    var tasks = [Task]() {
        didSet {
            self.saveTasks()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneBTN = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneChangeBTN))
        tableView.dataSource = self
        tableView.delegate = self
        loadTasks()
    }
    
    @objc func doneChangeBTN() {
        navigationItem.leftBarButtonItem = editBTN
        tableView.setEditing(false, animated: true)
    }

    @IBAction func editBTN(_ sender: UIBarButtonItem) {
        guard !tasks.isEmpty else { return }
        navigationItem.leftBarButtonItem = doneBTN
        tableView.setEditing(true, animated: true)
    }

    @IBAction func addBTN(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Insert To Do List", message: nil, preferredStyle: .alert)
        let registerBTN = UIAlertAction(title: "Register", style: .default) { [weak self] _ in
            guard let title = alert.textFields?[0].text else { return }
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()
        }
        let cancelBTN = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelBTN)
        alert.addAction(registerBTN)
        alert.addTextField { textField in
            textField.placeholder = "Insert To Do list"
        }
        present(alert, animated: true)
    }
    
    func saveTasks() {
        let data = tasks.map {
            [
                "title": $0.title,
                "done": $0.done
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "tasks")
    }
    
    func loadTasks() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
        tasks = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        if task.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        if self.tasks.isEmpty {
            self.doneChangeBTN()
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = tasks[indexPath.row]
        task.done = !task.done
        tasks[indexPath.row] = task
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

