import CoreData

@objc(WorkoutExercise)
public class WorkoutExercise: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var exerciseId: String
    @NSManaged public var workout: Workout
    @NSManaged public var sets: Set<ExerciseSet>?
    var setsArray: [ExerciseSet] {
        sets?.sorted { $0.id < $1.id } ?? []
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutExercise> {
        return NSFetchRequest<WorkoutExercise>(entityName: String(describing: WorkoutExercise.self))
    }
    convenience init(exerciseId: String, workout: Workout,
                     context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        self.init(context: context)
        self.exerciseId = exerciseId
        self.workout = workout
    }
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
    lazy var exercise: ExerciseEntity? = {
        ExerciseManager.shared.exercises.first(where: { $0.id == exerciseId })
    }()
}

extension WorkoutExercise: CoreDataModel {

}
