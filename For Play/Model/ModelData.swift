/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Storage for model data.
*/

import Foundation
import Combine


final class ModelData: ObservableObject {
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default
    //
   // @Published var activities: [Activity] = load("")
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }

    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
//    func signUp(
//          email: String,
//          password: String,
//          handler: @escaping AuthDataResultCallback
//          ) {
//          Auth.auth().createUser(withEmail: email, password: password, completion: handler)
//      }
//
//      func signIn(
//          email: String,
//          password: String,
//          handler: @escaping AuthDataResultCallback
//          ) {
//          Auth.auth().signIn(withEmail: email, password: password, completion: handler)
//      }
//
//      func signOut () -> Bool {
//          do {
//              try Auth.auth().signOut()
//              self.session = nil
//              return true
//          } catch {
//              return false
//          }
//      }
}





func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
