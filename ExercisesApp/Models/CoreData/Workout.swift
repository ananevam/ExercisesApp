import CoreData

@objc(Workout)
public class Workout: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var createdAt: Date
    @NSManaged public var exercises: NSSet?
    var exercisesArray: [WorkoutExercise] {
        (exercises as? Set<WorkoutExercise>)?.sorted { $0.exerciseId < $1.exerciseId } ?? []
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        let request = NSFetchRequest<Workout>(entityName: String(describing: Workout.self))
        return request
    }

    convenience init(name: String,
                     context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        self.init(context: context)
        self.name = name
    }

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
        createdAt = Date()
    }
    static func fetchAll(context: NSManagedObjectContext = CoreDataManager.shared.viewContext) -> [Workout] {
        let fetchRequest: NSFetchRequest<Workout> = fetchRequest()

        do {
            return try context.fetch(fetchRequest)
        } catch {
            return []
        }
    }
}
