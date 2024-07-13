//
//  PhoneBook+CoreDataProperties.swift
//  ContactsApp1
//
//  Created by pc on 7/13/24.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var phoneNumber: String?
    @NSManaged public var name: String?
    @NSManaged public var image: Data?

}

extension PhoneBook : Identifiable {

}
