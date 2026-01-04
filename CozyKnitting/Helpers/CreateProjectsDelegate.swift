import UIKit

protocol CreateProjectsDelegate: AnyObject {
    func didCreateNewProject(_ project: ProjectsModel)
}
