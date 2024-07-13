import UIKit
import SnapKit

class FriendListTableViewCell: UITableViewCell {
  let friendImage: UIImageView = {
    let imageView = UIImageView()
    imageView.layer.borderColor = UIColor(.black).cgColor
    imageView.layer.borderWidth = 1
    imageView.layer.cornerRadius = 25
    return imageView
  }()
  
  let friendName: UILabel = {
    let label = UILabel()
    label.text = ""
    return label
  }()
  
  let friendPhoneNumber: UILabel = {
    let label = UILabel()
    label.text = ""
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureFriendListTableViewCell()
    FriendListTableViewCellConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureFriendListTableViewCell() {
    [friendImage, friendName, friendPhoneNumber].forEach { contentView.addSubview($0) }
  }
  
  private func FriendListTableViewCellConstraints() {
    friendImage.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.leading.equalTo(contentView).offset(10)
      $0.width.height.equalTo(50)
    }
    friendName.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.leading.equalTo(friendImage.snp.trailing).offset(10)
      $0.width.equalTo(60)
    }
    friendPhoneNumber.snp.makeConstraints {
      $0.centerY.equalTo(contentView)
      $0.trailing.equalTo(contentView.snp.trailing).inset(30)
      $0.width.equalTo(130)
    }
  }
}
