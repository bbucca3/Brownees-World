//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Question {
    let question: String
    let ans: Bool 
    let explanation: String
    let category: String
    
    init(json: JSON) {
        self.question = json["title"].stringValue
        self.ans = json["answer"].boolValue
        self.explanation = json["explanation"].stringValue
        self.category = json["category"].stringValue
    }
}
