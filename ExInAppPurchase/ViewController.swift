//
//  ViewController.swift
//  ExInAppPurchase
//
//  Created by RLogixxTraining on 31/01/24.
//

import UIKit
import StoreKit

class ViewController: UIViewController,SKPaymentTransactionObserver,SKProductsRequestDelegate {
    
    enum Product:String,CaseIterable
    {
        case gems = "com.Rlogixx.ExInAppPurchase.gems"
        case premium = "com.Rlogixx.ExInAppPurchase.premium"
        case monthlySubs = "com.Rlogixx.ExInAppPurchase.Monthly"
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if let oProduct = response.products.first{
            print("Product is Availbale")
            self.purchase(aproduct: oProduct)
        }else{
            print("Product is not Available")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                print("Customer is in process of purchasing")
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("purchased")
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Failed")
            case .restored:
                print("restored")
            case .deferred:
                print("Deffered")
            default:
                break
            }
        }
    }
    func purchase(aproduct:SKProduct){
        let payment = SKPayment(product: aproduct)
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().add(payment)
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBuyGems(_ sender: Any) {
        if SKPaymentQueue.canMakePayments(){
            let set : Set<String> = [Product.gems.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
        
        
    }
    

    @IBAction func btnMonthly(_ sender: Any) {
        if SKPaymentQueue.canMakePayments(){
            let set : Set<String> = [Product.monthlySubs.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
        
    }
    @IBAction func btnPremium(_ sender: Any) {
        if SKPaymentQueue.canMakePayments(){
            let set : Set<String> = [Product.premium.rawValue]
            let productRequest = SKProductsRequest(productIdentifiers: set)
            productRequest.delegate = self
            productRequest.start()
        }
        
    }
    
    
}

