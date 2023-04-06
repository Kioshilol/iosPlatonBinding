
import UIKit
import PlatonSDK

class ScheduleViewController: UIViewController {

    // MARK: - Properties
    // Views
    @IBOutlet var tfOrderAmount: UITextField!
    @IBOutlet var tfOrderDescription: UITextField!
    
    @IBOutlet var tfPayerEmail: UITextField!
    @IBOutlet var tfCardNumber: UITextField!
    @IBOutlet var tfFirstTransId: UITextField!
    @IBOutlet var tfRecurringToken: UITextField!
    @IBOutlet var tfPeriod: UITextField!
    @IBOutlet var tfInitPeriod: UITextField!
    @IBOutlet var tfRepeatTimes: UITextField!
    
    @IBOutlet var lbResponse: UILabel!
    
    // Constraints
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfOrderAmount.text = "15"
        tfOrderDescription.text = "Accusantium est aut rem eum. Repellat consequatur nesciunt nihil. Autem culpa omnis."
        
        tfPayerEmail.text = "ulices@casper.bz"
        tfCardNumber.text = PlatonCard(test: .success).number
        tfFirstTransId.text = UserDefaults.standard.string(forKey: PlatonMethodProperty.transId.stringValue)
        tfRecurringToken.text = UserDefaults.standard.string(forKey: PlatonMethodProperty.recurringToken.stringValue)
        
        tfPeriod.text = "3"
        tfInitPeriod.text = "2"
        tfRepeatTimes.text = "3"
    }
    
    // MARK: - Actions

    @IBAction func scheduleAction(_ sender: LoadingButton) {
        sender.isLoading = true
        view.endEditing(true)
        
        var period = Int(tfInitPeriod.text ?? "") ?? 0
        var repeatTimes = Int(tfRepeatTimes.text ?? "") ?? 0
        
        let order = PlatonOrder(amount: Float(tfOrderAmount.text ?? "") ?? 0, orderDescription: tfOrderDescription.text ?? "")
        let recurring = PlatonRecurring(firstTransId: tfFirstTransId.text ?? "", token: tfRecurringToken.text ?? "")
        let scheduleAdditional = PlatonScheduleAdditonal(initDelayDays: period, repeatTimes: repeatTimes)
        
        PlatonPostPayment.schedule.schedule(order: order,
                                           recurring: recurring,
                                           periodDays: Int(tfPeriod.text ?? "") ?? 0,
                                           payerEmail: tfPayerEmail.text ?? "",
                                           cardNumber: tfCardNumber.text ?? "",
                                           scheduleAdditonal: scheduleAdditional) { (result) in
                                            sender.isLoading = false
                                            
                                            switch result {
                                            case .failure(let error):
                                                self.lbResponse.text = "\(error)"
                                            default:
                                                self.lbResponse.text = "\(result.responseObject!)"
                                            }
                                            
        }
        
    }
    
}
