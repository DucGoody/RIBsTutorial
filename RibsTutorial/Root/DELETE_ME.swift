////
////  DELETE_ME.swift
////  RibsTutorial
////
////  Created by DUCHV3 on 12/16/19.
////  Copyright © 2019 DUCHV3. All rights reserved.
////
//
//import RIBs
//
//protocol LoggedOutDependency {}
//
//protocol LoggedOutListener {}
//
//protocol LoggedOutBuildable {
//    func build(withListener: LoggedOutListener) -> ViewableRouting
//}
//
//class LoggedOutInteractor: Interactor {}
//
//class LoggedOutViewController: UIViewController, ViewControllable {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("ABC XYZ")
//    }
//}
//
//class LoggedOutBuilder: LoggedOutBuildable {
//    init(dependency: Any) {}
//    func build(withListener: LoggedOutListener) -> ViewableRouting {
//        return ViewableRouter<Interactable, ViewControllable>(interactor: LoggedOutInteractor(), viewController: LoggedOutViewController())
//    }
//}
