//
//  ViewController.swift
//  fireBase
//
//  Created by R82 on 17/07/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseFirestore

class ViewController: UIViewController {

    var ref: DatabaseReference!
    var refr: Firestore!

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tx3: UITextField!
    @IBOutlet weak var tx2: UITextField!
    @IBOutlet weak var tx1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        refr = Firestore.firestore()
      
    }
   
    @IBAction func save(_ sender: Any) {
       // realTime()
       // fireStore()
        
    }
    func realTime(){
        ref.child("Students").childByAutoId().setValue(["id":tx1.text!,"name": tx2.text!,"email": tx3.text!,"image":img.image?.description])
        
    }
    func fireStore(){
        //refr.collection("iOS").document(tx1.text!).setData(["name":tx2.text])
    //    refr.collection("iOS").addDocument(data: ["name":tx2.text])
        refr.collection("iOS").document(Auth.auth().currentUser?.uid ?? "" ).setData(["E-Mail": tx1.text!,"password": tx2.text!])
    }
    func signUp(){
        Auth.auth().createUser(withEmail: tx1.text!, password: tx2.text!) { [self] authResult, error in
            if error == nil{
                var uid = authResult?.user.uid
                refr.collection("iOS").document(uid!).setData(["E-Mail": tx1.text!,"password": tx2.text!])
            }
        }
    }
    func signIn(){
        Auth.auth().signIn(withEmail: tx1.text!, password: tx2.text!){ authResult, error in
            if error == nil{
                print("done")
            }
            else{
                print(error?.localizedDescription)
            }
        }
    }
    func data(){
//        if let user = user {
//          let uid = user.uid
//          let email = user.email
//          let photoURL = user.photoURL
//          var multiFactorString = "MultiFactor: "
//          for info in user.multiFactor.enrolledFactors {
//            multiFactorString += info.displayName ?? "[DispayName]"
//            multiFactorString += " "
//          }
//        }
    }
    @IBAction func sighUp(_ sender: Any) {
        signUp()
        
    }
    

    @IBAction func sighIn(_ sender: Any) {
        signIn()
    }
    
}

