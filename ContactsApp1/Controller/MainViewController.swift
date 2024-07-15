import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var container: NSPersistentContainer!
  var friends: [NSManagedObject] = []
  var mainView: MainView!
  
  override func loadView() {
    mainView = MainView(frame: UIScreen.main.bounds)
    self.view = mainView
    self.title = "친구 목록"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addfriendButtonTapped))
    self.navigationItem.rightBarButtonItem?.tintColor = .gray
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    self.container = appDelegate.persistentContainer
    setUpTableView()
    
  }
  
  override func viewIsAppearing(_ animated: Bool) {
    super.viewIsAppearing(animated)
    loadFriendsData()
    mainView.friendsTableView.reloadData()
  }
  
  @objc private func addfriendButtonTapped() {
    let editPageViewController = EditPageViewController()
    editPageViewController.title = "연락처 추가"
    self.navigationController?.pushViewController(editPageViewController, animated: true)
  }
  
  func setUpTableView() {
    mainView.friendsTableView.dataSource = self
    mainView.friendsTableView.delegate = self
    mainView.friendsTableView.register(FriendListTableViewCell.self, forCellReuseIdentifier: "FriendListTableViewCell")
  }
  
  func loadFriendsData() {
    do {
      let fetchRequest: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest()
      fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
      let phoneBooks = try self.container.viewContext.fetch(fetchRequest)
      friends = phoneBooks
    } catch {
      print("")
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return friends.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "FriendListTableViewCell",
      for: indexPath
    ) as? FriendListTableViewCell else {
      return UITableViewCell()
    }
    let friend = friends[indexPath.row]
    cell.friendName.text = friend.value(forKey: "name") as? String
    cell.friendPhoneNumber.text = friend.value(forKey: "phoneNumber") as? String
    
    if let imageData = friend.value(forKey: "image") as? Data {
      cell.friendImage.image = UIImage(data: imageData)
    } else {
      cell.friendImage.image = UIImage()
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let friend = friends[indexPath.row]
    let editPageViewController = EditPageViewController()
    editPageViewController.friend = friend
    editPageViewController.container = container
    editPageViewController.title = friend.value(forKey: "name") as? String
    self.navigationController?.pushViewController(editPageViewController, animated: true)
  }
}
