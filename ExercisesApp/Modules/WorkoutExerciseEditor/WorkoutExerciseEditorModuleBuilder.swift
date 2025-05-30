import UIKit

class WorkoutExerciseEditorModuleBuilder {
    static func build(workoutExercise: WorkoutExercise) -> UIViewController {
        let view = WorkoutExerciseEditorView()
        let interactor = WorkoutExerciseEditorInteractor()
        let router = WorkoutExerciseEditorRouter()

        let presenter = WorkoutExerciseEditorPresenter(
            workoutExercise: workoutExercise,
            view: view,
            interactor: interactor,
            router: router
        )

        view.output = presenter
        interactor.output = presenter
        router.viewController = view

        return view
    }
}
