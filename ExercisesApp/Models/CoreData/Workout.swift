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
}
