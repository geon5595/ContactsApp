import UIKit
import SnapKit

class MainView: UIView {
  
  let friendsTableView: UITableView = {
    let tableView = UITableView()
    tableView.rowHeight = 60
    return tableView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    configureMainViewUI()
    mainViewConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureMainViewUI() {
    [friendsTableView].forEach{ self.addSubview($0) }
  }
  
  private func mainViewConstraints() {
    friendsTableView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(120)
      $0.leading.equalToSuperview().offset(30)
      $0.trailing.equalToSuperview().offset(-30)
      $0.bottom.equalToSuperview().offset(-30)
    }
  }
}
