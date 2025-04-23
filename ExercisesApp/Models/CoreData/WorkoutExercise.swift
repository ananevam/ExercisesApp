import CoreData

@objc(WorkoutExercise)
public class WorkoutExercise: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var exerciseId: String
    @NSManaged public var workout: Workout

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutExercise> {
        return NSFetchRequest<WorkoutExercise>(entityName: String(describing: WorkoutExercise.self))
    }
    lazy var exercise: ExerciseEntity? = {
        ExerciseManager.shared.exercises.first(where: { $0.id == exerciseId })
    }()
}

extension WorkoutExercise: CoreDataModel {}
