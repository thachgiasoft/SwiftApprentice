import Foundation

public class CheckingAccount: BasicAccount {
    private let accountNumber = UUID().uuidString
    public class Check {
        let account: String
        var amount: Dollars
        private(set) var cashed = false
        func cash() {
            cashed = true
        }
        fileprivate init(amount: Dollars, from account: CheckingAccount) {
            self.amount = amount
            self.account = account.accountNumber
        }
    }
    public func writeCheck(amount: Dollars) -> Check? {
        guard balance > amount else {
            return nil
        }
        let check = Check(amount: amount, from: self)
        withdraw(amount: check.amount)
        return check
    }
    public func deposit(_ check: Check) {
        guard !check.cashed else { return }
        deposit(amount: check.amount)
        check.cash()
    }
    public override init() { }
}
