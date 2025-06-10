//
//  PageCurlView.swift
//  iMora
//
//  Created by Jonathan Mora on 03/06/25.
//


import SwiftUI
import UIKit

struct PageCurlView: UIViewControllerRepresentable {
    let views: [UIViewController]

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageVC = UIPageViewController(
            transitionStyle: .pageCurl,
            navigationOrientation: .horizontal,
            options: nil
        )

        pageVC.dataSource = context.coordinator
        pageVC.setViewControllers([views[0]], direction: .forward, animated: true)

        return pageVC
    }

    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        // No update needed
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(views: views)
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource {
        var views: [UIViewController]

        init(views: [UIViewController]) {
            self.views = views
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = views.firstIndex(of: viewController), index > 0 else { return nil }
            return views[index - 1]
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = views.firstIndex(of: viewController), index + 1 < views.count else { return nil }
            return views[index + 1]
        }
    }
}
