import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()

    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    private init() {}

    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func saveWorkout(name: String) -> Workout? {
        let workout = Workout(context: viewContext)
        workout.id = UUID()
        workout.name = name
        workout.createdAt = Date()

        do {
            try viewContext.save()
            return workout
        } catch {
            print("Saving error: \(error)")
            return nil
        }
    }
    func loadWorkouts() -> [Workout] {
        let fetchRequest: NSFetchRequest<Workout>  = Workout.fetchRequest()

        do {
            return try viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
