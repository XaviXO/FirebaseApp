//
//  ViewController.swift
//  FirestoreApp
//
//  Created by Javier Calderon Jr. on 1/13/20.
//  Copyright © 2020 RockefellerMagic. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

      @IBOutlet var tableView: UITableView!

      var itemsData: [Stuff] = []
      var itemListener: ListenerRegistration?

      private func startListeningForStuff() {
        let basicQuery = Firestore.firestore().collection("stuff").limit(to: 50)
        itemListener = basicQuery.addSnapshotListener { (snapshot, error) in
          if let error = error {
            print ("I got an error retrieving restaurants: \(error)")
            return
          }
          guard let snapshot = snapshot else { return }
          self.itemsData = []
          for itemDocument in snapshot.documents {
            if let newItems = Stuff(document: itemDocument) {
              self.itemsData.append(newItems)
            }
          }
          self.tableView.reloadData()
        }
      }

      func tryASampleQuery() {
        let basicQuery = Firestore.firestore().collection("stuff").limit(to: 3)
        basicQuery.getDocuments { (snapshot, error) in
          if let error = error {
            print("Oh no! Got an error! \(error.localizedDescription)")
            return
          }
          guard let snapshot = snapshot else { return }
          let allDocuments = snapshot.documents
          for itemDocument in allDocuments {
            print("I have this restaurant \(itemDocument.data())")
          }
        }
      }

      private func stopListeningForStuff() {
        itemListener?.remove()
        itemListener = nil
      }

      override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tryASampleQuery()
      }

      override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        startListeningForStuff()
      }

      override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopListeningForStuff()
      }

      // MARK: - Table view data source

      func numberOfSections(in tableView: UITableView) -> Int {
        return 1
      }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsData.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StuffCell",for: indexPath) as! StuffCell
        let items = itemsData[indexPath.row]
        cell.populate(item: items)
        return cell
      }

    }
