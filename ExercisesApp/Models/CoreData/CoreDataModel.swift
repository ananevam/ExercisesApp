import CoreData

protocol CoreDataModel {
    func save()
    func delete()
}

extension CoreDataModel where Self: NSManagedObject {
    func save() {
        if Self.context.hasChanges {
            do {
                try Self.context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func delete() {
        Self.context.delete(self)

        save()
    }
    static var fetchRequest: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: String(describing: self))
        request.sortDescriptors = []
        return request
    }
    static var all: [Self] {
        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    static var context: NSManagedObjectContext {
        CoreDataManager.shared.viewContext
    }
    static var entityName: String {
        String(describing: self)
    }
}
