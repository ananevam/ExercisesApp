import CoreData

@objc(ExerciseSet)
public class ExerciseSet: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var exercise: WorkoutExercise

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseSet> {
        return NSFetchRequest<ExerciseSet>(entityName: String(describing: ExerciseSet.self))
    }
    convenience init(exercise: WorkoutExercise,
                     context: NSManagedObjectContext = CoreDataManager.shared.viewContext) {
        self.init(context: context)
        self.exercise = exercise
    }
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        id = UUID()
    }
}

extension ExerciseSet: CoreDataModel {}
