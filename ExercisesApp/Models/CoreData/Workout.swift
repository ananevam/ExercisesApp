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

//    static func fetchBy(
//        id: UUID, context: NSManagedObjectContext = CoreDataManager.shared.viewContext
//    ) -> Workout? {
//        let request: NSFetchRequest<Workout> = fetchRequest()
//        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
//        request.fetchLimit = 1
//
//        do {
//            return try context.fetch(request).first
//        } catch {
//            return nil
//        }
//    }
}
extension Workout: CoreDataModel {

}
