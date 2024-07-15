import UIKit
import Alamofire
import CoreData

class EditPageViewController: UIViewController {
  var friend: NSManagedObject?
  var container: NSPersistentContainer!
  var editPageView: EditPageView!
  
  override func loadView() {
    editPageView = EditPageView(frame: UIScreen.main.bounds)
    self.view = editPageView
    self.navigationItem.backButtonTitle = "Back"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(applyButtonTapped))
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    self.container = appDelegate.persistentContainer
    editPageView.createRandomProfileImage.addTarget(self, action: #selector(createRandomProfileImageButtonTapped), for: .touchUpInside)
    
    if let friend = friend {
      editPageView.nameTextView.text = friend.value(forKey: "name") as? String
      editPageView.phoneNumberTextView.text = friend.value(forKey: "phoneNumber") as? String
      if let imageData = friend.value(forKey: "image") as? Data {
        editPageView.profileImage.image = UIImage(data: imageData)
      }
    }
  }
  
  @objc private func createRandomProfileImageButtonTapped() {
    fetchPokemonData()
  }
  
  @objc private func applyButtonTapped() {
    saveData()
    self.navigationController?.popViewController(animated: true)
  }
  
  func saveData() {
    guard let name = editPageView.nameTextView.text, !name.isEmpty,
          let phoneNumber = editPageView.phoneNumberTextView.text, !phoneNumber.isEmpty,
          let image = editPageView.profileImage.image else { return }
    
    coreData(name: name, phoneNumber: phoneNumber, image: image)
  }
  
  func coreData(name: String, phoneNumber: String, image: UIImage) {
    guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext) else { return }
    
    let phoneBook: NSManagedObject
    if let friend = friend {
      phoneBook = friend
    } else {
      phoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
    }
    phoneBook.setValue(name, forKey: "name")
    phoneBook.setValue(phoneNumber, forKey: "phoneNumber")
    if let imageData = image.pngData() {
      phoneBook.setValue(imageData, forKey: "image")
    }
    
    do {
      try self.container.viewContext.save()
    } catch {
      print("")
    }
  }
  
  private func randomNumber() -> Int {
    return Int.random(in: 1...1000)
  }
  
  private func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
    AF.request(url).responseDecodable(of: T.self) { response in
      completion(response.result)
    }
  }
  
  private func fetchPokemonData() {
    let urlComponents = URLComponents(string: "https://pokeapi.co/api/v2/pokemon/\(randomNumber())")
    guard let url = urlComponents?.url else { return }
    
    fetchData(url: url) { [weak self] (result: Result<PokemonCharacterImage, AFError>) in
      switch result {
      case .success(let result):
        
        guard let imageUrl = URL(string: result.sprites.frontDefault) else { return }
        AF.request(imageUrl).responseData { response in
          if let data = response.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
              self?.editPageView.profileImage.image = image
            }
          }
        }
      case .failure(_):
        print("")
      }
    }
  }
}
