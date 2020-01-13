//
//  Stuff.swift
//  FirestoreApp
//
//  Created by Javier Calderon Jr. on 1/13/20.
//  Copyright © 2020 RockefellerMagic. All rights reserved.
//

import Firebase
import FirebaseFirestore

struct Stuff {
    
  var documentID: String
  var name: String
  var brand: String
  var price: Int
  var weight: String

}

extension Stuff: DocumentSerializable {

  init(name: String,
       brand: String,
       weight: String,
       price: Int) {
    let document = Firestore.firestore().stuff.document()
    self.init(documentID: document.documentID,
              name: name,
              brand: brand,
              price: price,
              weight: weight)
  }

  private init?(documentID: String, dictionary: [String: Any]) {
    guard let name = dictionary["name"] as? String,
        let brand = dictionary["brand"] as? String,
        let weight = dictionary["weight"] as? String,
        let price = dictionary["price"] as? Int else { return nil }

    self.init(documentID: documentID,
              name: name,
              brand: brand,
              price: price,
              weight: weight)
  }

  init?(document: QueryDocumentSnapshot) {
    self.init(documentID: document.documentID, dictionary: document.data())
  }

  init?(document: DocumentSnapshot) {
    guard let data = document.data() else { return nil }
    self.init(documentID: document.documentID, dictionary: data)
  }

  var documentData: [String: Any] {
    return [
      "name": name,
      "brand": brand,
      "weight": weight,
      "price": price
    ]
  }

}
