//
//  CourseStore.swift
//  WHUT
//
//  Created by Nic Demai on 12/4/20.
//

import SwiftUI
import Contentful
import Combine

let client = Client(spaceId: "0ge8xzmnbp2c", environmentId: "master", accessToken: "03010b0d79abcb655ca3fda453f2f493b5472e0aaa53664bc7dea5ef4fce2676")


func getArray(typeId: String, completion: @escaping([Entry]) -> ()) {
    let query = Query.where(contentTypeId: typeId)
    
    client.fetchArray(of: Entry.self, matching: query) { result in
        switch result {
        case .success(let array):
            DispatchQueue.main.async {
                completion(array.items)
            }

        case.failure(let error):
            print(error)
        }
    }
    .resume()
}

class CourseStore: ObservableObject {
    @Published var courses: [Course] = courseData
    
    init() {
        let colors = [#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)]
        var index = 0
        
        getArray(typeId: "course") { (items) in
            items.forEach { item in
                
                self.courses.append(
//                    Course(
//                        title: item.fields["title"] as! String,
//                        subtitle: item.fields["subtitle"] as! String,
//                        text: item.fields["Description"] as! String,
//                        image: item.fields.linkedAsset(at: "Image")!.url ?? URL(string: "")!,
//                        logo: #imageLiteral(resourceName: "Logo"),
//                        color: colors[index],
//                        show: false
//                    )
                    Course(title: item.fields["title"]as! String,
                           subtitle: item.fields["subtitle"] as! String,
                           text: item.fields["text"] as! String,
                           image: item.fields.linkedAsset(at: "image")!.url ?? URL(string: "")!,
                           logo: #imageLiteral(resourceName: "Logo"),
                           color: colors.randomElement()!,
                           show: false)
                )
                index = index + 1
            }
        }
    }
}
