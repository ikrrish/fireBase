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
        sendOtp()
//        Auth.auth().signIn(withEmail: tx1.text!, password: tx2.text!){ authResult, error in
//            if error == nil{
//                print("done")
//            }
//            else{
//                print(error?.localizedDescription)
//            }
//        }
    }
    @IBAction func sighUp(_ sender: Any) {
        signUp()
        
    }
    @IBAction func sighIn(_ sender: Any) {
        signIn()
    }
    func phoneNumber(){
        
    }
    func sendOtp() {
        PhoneAuthProvider.provider().verifyPhoneNumber(tx1.text!, uiDelegate: nil) { [self] verificationID, error in
            if error == nil {
                print("done")
                showAlert(id:verificationID!)
            }
            else{
                print(error?.localizedDescription)
            }
        }
    }
    func showAlert(id:String){
        let a = UIAlertController(title: "OTP", message: "EnterOTP", preferredStyle: .alert)
        a.addTextField()
        a.addAction(UIAlertAction(title: "ok", style: .default,handler: { _ in
            self.verifyOtp(token: id, otp: (a.textFields?.first?.text)!)
        }))
        present(a, animated: true)
    }
    func verifyOtp(token:String,otp:String){
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: token, verificationCode: otp)
        Auth.auth().signIn(with: credential) { authDataResult, error in
            if error == nil{
                print("ok")
            }
            else{
                print(error?.localizedDescription)
            }
        }
    }
}

