//
//  FirestoreCollection.swift
//  FirestoreApp
//
//  Created by Javier Calderon Jr. on 1/13/20.
//  Copyright © 2020 RockefellerMagic. All rights reserved.
//

import FirebaseFirestore

extension Firestore {
    var stuff: CollectionReference {
      return self.collection("stuff")
    }
}
extension Firestore {
  func add(stuff: Stuff) {
    self.stuff.document(stuff.documentID).setData(stuff.documentData)
  }
}

extension WriteBatch {
  func add(stuff: Stuff) {
    let document = Firestore.firestore().stuff.document(stuff.documentID)
    self.setData(stuff.documentData, forDocument: document)
  }
}
