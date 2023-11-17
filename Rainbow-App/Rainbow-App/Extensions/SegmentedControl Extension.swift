import Foundation
import UIKit

extension UISegmentedControl {

    static func makeController(segments amount: Int, item1: String, item2: String, item3: String?, item4: String?) -> UISegmentedControl {

        if amount == 3 {
            let controller = UISegmentedControl(items: [item1, item2, item3 ?? ""])
            return controller
        }

        if amount == 4 {
            let controller = UISegmentedControl(items: [item1, item2, item3 ?? "", item4 ?? ""])
            return controller
        }

        let controller = UISegmentedControl(items: [item1, item2])
        return controller
    }
}
