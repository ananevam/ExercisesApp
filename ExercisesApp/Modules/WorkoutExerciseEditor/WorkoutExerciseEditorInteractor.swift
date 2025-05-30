import Foundation

protocol WorkoutExerciseEditorInteractorInput {
    var output: WorkoutExerciseEditorInteractorOutput? {get set}
}

protocol WorkoutExerciseEditorInteractorOutput: AnyObject {

}

class WorkoutExerciseEditorInteractor: WorkoutExerciseEditorInteractorInput {
    weak var output: WorkoutExerciseEditorInteractorOutput?
}
