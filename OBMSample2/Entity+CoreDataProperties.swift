import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var savedTime: String
    @NSManaged public var savedData: String

}

extension Entity : Identifiable {

}
