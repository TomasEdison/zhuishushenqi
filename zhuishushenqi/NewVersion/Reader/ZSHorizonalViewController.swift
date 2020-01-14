//
//  ZSHorizonalViewController.swift
//  zhuishushenqi
//
//  Created by caony on 2019/7/9.
//  Copyright © 2019 QS. All rights reserved.
//

import UIKit

class ZSHorizonalViewController: BaseViewController, ZSReaderVCProtocol {
    
    fileprivate var pageVC:PageViewController = PageViewController()
    
    weak var toolBar:ZSReaderToolbar?
    
    weak var dataSource:UIPageViewControllerDataSource?
    weak var delegate:UIPageViewControllerDelegate?
    
    var nextPageHandler: ZSReaderPageHandler?
    
    var lastPageHandler: ZSReaderPageHandler?
    
    lazy var horizonalController:UIPageViewController = {
        var transitionStyle:UIPageViewController.TransitionStyle = .scroll
        let controller = UIPageViewController(transitionStyle: transitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        controller.dataSource = self
        controller.delegate = self
        controller.isDoubleSided = false
        controller.setViewControllers([pageVC], direction: .forward, animated: true, completion: nil)
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.horizonalController.view.superview != self.view {
            self.horizonalController.view.removeFromSuperview()
            self.addChild(self.horizonalController)
            self.view.addSubview(self.horizonalController.view)
            self.horizonalController.didMove(toParent: self)
        }
    }
    
    func bind(toolBar: ZSReaderToolbar) {
        self.toolBar = toolBar
    }
    
    func destroy() {
        if let controllers = horizonalController.viewControllers as? [PageViewController] {
            for controller in controllers {
                controller.destroy()
            }
        }
        pageVC.destroy()
    }
    
    func changeBg(style: ZSReaderStyle) {
        pageVC.bgView.image = style.backgroundImage
    }
    
    func jumpPage(page: ZSBookPage) {
        pageVC.newPage = page
        horizonalController.setViewControllers([pageVC], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func tapAction(tap:UITapGestureRecognizer) {
        toolBar?.show(inView: view, true)
    }
}

extension ZSHorizonalViewController:UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return dataSource?.pageViewController(pageViewController, viewControllerBefore: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return dataSource?.pageViewController(pageViewController, viewControllerAfter: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool){
        delegate?.pageViewController?(pageViewController, didFinishAnimating: finished, previousViewControllers: previousViewControllers, transitionCompleted: completed)
        if !completed {
            guard let pageVC = previousViewControllers.first as? PageViewController else { return }
            self.pageVC = pageVC
        } else {
            
        }
    }
}
