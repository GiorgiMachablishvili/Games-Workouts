

import Foundation
import StoreKit

@available(iOS 15.0, *)
typealias RenewalStatic = StoreKit.Product.SubscriptionInfo.RenewalState

@available(iOS 15.0, *)
class StoreVM: ObservableObject {

    @Published private(set) var subscriptions: [Product] = []
    @Published private(set) var purchasedSubscriptions: [Product] = []
    @Published private(set) var subscriptionGroupStatus: RenewalStatic?


//    let productIds: [String] = ["subscription.yearly", "subscription.monthly"]
    let productIds: [String] = ["bsu_1499_1year", "bsu_199_1month"]

    var updateListenerTask : Task<Void, Error>? = nil

    init() {
        
        updateListenerTask = listenForTransaction()

        Task {
            await requestProducts()

            await updateCustomerProductStatus()
        }
    }

    deinit {
        updateListenerTask?.cancel()
    }

    func listenForTransaction() -> Task<Void, Error> {
        return Task.detached {
            //Iterate through any transactions that don't come from a direct call to 'purchase()'.
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    // deliver products to the user
                    await self.updateCustomerProductStatus()

                    await transaction.finish()
                } catch {
                    print("transaction failed verification")
                }
            }
        }
    }

    @MainActor
//    func requestProducts() async {
//        do {
//            subscriptions = try await Product.products(for: productIds)
//            print("✅ Products fetched: \(subscriptions.map { $0.id })")
//        } catch {
//            print("❌ Failed to fetch products: \(error)")
//        }
//    }

    func requestProducts() async {
        do {
            print("⏳ Requesting products from App Store...")
            subscriptions = try await Product.products(for: productIds)
            print("✅ Products fetched: \(subscriptions.map { $0.id })")

            if subscriptions.isEmpty {
                print("❌ No products found! Check App Store Connect.")
            }
        } catch {
            print("❌ Failed to fetch products: \(error.localizedDescription)")
        }
    }

    //purchase the product
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()

        switch result {
        case.success(let verification):
            //Check whether the transaction is verified. If it isn't,
            //this function rethrows the verification error.
            let transaction = try checkVerified(verification)

            //The transaction is verified. Deliver content to the user.
            await updateCustomerProductStatus()

            //Always finish a transaction.
            await transaction.finish()

            return transaction

        case.userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }


    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit parses the JWS, but it fails verification.
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }

    }

    @MainActor
    func updateCustomerProductStatus() async {
        var hasActiveSubscription = false
        purchasedSubscriptions.removeAll()

        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)
                switch transaction.productType {
                case .autoRenewable:
                    hasActiveSubscription = true
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedSubscriptions.append(subscription)
                    }
                default:
                    break
                }
                await transaction.finish()
            } catch {
                print("Failed to verify transaction.")
            }
        }

        // Update subscription group status
        subscriptionGroupStatus = hasActiveSubscription ? .subscribed : .expired

        UserDefaults.standard.setValue(hasActiveSubscription, forKey: "isSubscribed")
    }
}

public enum StoreError: Error {
    case failedVerification
}
