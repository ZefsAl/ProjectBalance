//

//  CryptoBalance
//
//  Created by Serj on 10.04.2023.
//

import Foundation
import UIKit


// Exclude Duplicates
public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
