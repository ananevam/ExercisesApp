import UIKit

class MusclesModuleBuilder {
    static func build() -> UIViewController {
        let view = MusclesView()
        let interactor = MusclesInteractor()
        let router = MusclesRouter()

        let presenter = MusclesPresenter(
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
