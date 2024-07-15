//
//  EditPageView.swift
//  ContactsApp
//
//  Created by pc on 7/11/24.
//

import UIKit
import SnapKit

class EditPageView: UIView {
  let profileImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Image")
    imageView.layer.borderColor = UIColor.black.cgColor
    imageView.layer.borderWidth = 1
    imageView.layer.cornerRadius = 75
    imageView.clipsToBounds = true
    return imageView
  }()
  let createRandomProfileImage: UIButton = {
    let button = UIButton()
    button.setTitle("랜덤 이미지 생성", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
    return button
  }()
  let nameTextView: UITextView = {
    let textView = UITextView()
    textView.text = ""
    textView.font = UIFont.systemFont(ofSize: 10)
    textView.textColor = .black
    textView.layer.borderWidth = 1
    textView.layer.borderColor = UIColor.lightGray.cgColor
    textView.layer.cornerRadius = 5
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  let phoneNumberTextView: UITextView = {
    let textView = UITextView()
    textView.text = ""
    textView.font = UIFont.systemFont(ofSize: 10)
    textView.textColor = .black
    textView.layer.borderWidth = 1
    textView.layer.borderColor = UIColor.lightGray.cgColor
    textView.layer.cornerRadius = 5
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    configureEditPageView()
    editPageViewConstarints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureEditPageView() {
    [profileImage, createRandomProfileImage, nameTextView, phoneNumberTextView].forEach{ self.addSubview($0) }
  }
  
  private func editPageViewConstarints() {
    
    profileImage.snp.makeConstraints {
      $0.width.height.equalTo(150)
      $0.centerX.equalToSuperview()
      $0.top.equalToSuperview().inset(120)
    }
    createRandomProfileImage.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(profileImage.snp.bottom).offset(10)
    }
    nameTextView.snp.makeConstraints {
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(20)
      $0.top.equalTo(createRandomProfileImage.snp.bottom).offset(20)
      $0.height.equalTo(30)
    }
    phoneNumberTextView.snp.makeConstraints {
      $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(20)
      $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(20)
      $0.top.equalTo(nameTextView.snp.bottom).offset(10)
      $0.height.equalTo(30)
    }
  }
}
