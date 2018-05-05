import UIKit
import SnapKit

protocol TripDelegate {
   func makeNewTrip(trip: Trip)
}

let backgroundOrange = UIColor(red: 235/255, green: 145/255, blue: 30/255, alpha: 1)
let orange2 = UIColor(red: 255/255, green: 185/255, blue: 80/255, alpha: 0.5)

class NTViewController: UIViewController, TripsLengthDelegate, DateDelegate {
   func setDate(date: Date, pickingSd: Bool) {
      if pickingSd {
         startDate = date
      }
      else {
         endDate = date
      }
   }
   
   
   
   func tripLen(len: Int!) {
      self.tripid = len
   }
   
   var tripid: Int!
   var tripToSave: Trip!
   var slLabel: UILabel!
   var slTextField: UITextField!
   var elLabel: UILabel!
   var elTextField: UITextField!
   var hotelLabel: UILabel!
   var hotelTextField: UITextField!
   var saveButton: UIButton!
   var dButton: UIButton!
   var warningLabel: UILabel!
   var pickStartDateButton: UIButton!
   var pickEndDateButton: UIButton!
   var startDate: Date!
   var endDate: Date!
   
   
   var delegate: TripDelegate!
   var proportionStackView: UIStackView!
   var tripType: UISegmentedControl!
   var tripTypeLabel: UILabel!
   var useType: TripType = .plane
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      view.backgroundColor = .white
      title = "New Trip"
      
      //      let image = UIImage(named: "map.jpeg")!
      //      let imgView = UIImageView(frame: view.bounds)
      //      imgView.contentMode = .scaleAspectFill
      //      imgView.image = image
      //      view.addSubview(imgView)
      
      tripTypeLabel = UILabel()
      tripTypeLabel.text = "Will travel by: "
      tripTypeLabel.textColor = backgroundOrange
      tripTypeLabel.font = UIFont.systemFont(ofSize: 36)
      
      tripType = UISegmentedControl(items: ["Car", "Plane"])
      tripType.addTarget(self, action: #selector(tripTypeChanged), for: .valueChanged)
      tripType.selectedSegmentIndex = 1
      tripType.tintColor = backgroundOrange
      view.addSubview(tripTypeLabel)
      view.addSubview(tripType)
      
      pickStartDateButton = UIButton()
      pickStartDateButton.setTitle("Pick Start Date", for: .normal)
      pickStartDateButton.setTitleColor(backgroundOrange, for: .normal)
      pickStartDateButton.addTarget(self, action: #selector(pickStartDateButtonPressed), for: .touchUpInside)
      pickStartDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
      pickStartDateButton.backgroundColor = orange2
      pickStartDateButton.layer.cornerRadius = 12
      view.addSubview(pickStartDateButton)
      
      pickEndDateButton = UIButton()
      pickEndDateButton.setTitle("Pick End Date", for: .normal)
      pickEndDateButton.setTitleColor(backgroundOrange, for: .normal)
      pickEndDateButton.addTarget(self, action: #selector(pickEndDateButtonPressed), for: .touchUpInside)
      pickEndDateButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
      pickEndDateButton.backgroundColor = orange2
      pickEndDateButton.layer.cornerRadius = 12
      view.addSubview(pickEndDateButton)
      
      
      
      startDate = Date.init()
      endDate = Date.init(timeIntervalSinceNow: 86400)
      
      slLabel = UILabel()
      slLabel.text = "Start Location"
      slLabel.textColor = backgroundOrange
      slLabel.font = UIFont.systemFont(ofSize: 36)
      view.addSubview(slLabel)
      
      slTextField = UITextField()
      slTextField.placeholder = "Insert text"
      slTextField.layer.borderWidth = 1
      slTextField.layer.cornerRadius = 6
      slTextField.textAlignment = .center
      slTextField.font = UIFont.systemFont(ofSize: 24)
      view.addSubview(slTextField)
      
      
      elLabel = UILabel()
      elLabel.text = "End Location"
      elLabel.textColor = backgroundOrange
      elLabel.font = UIFont.systemFont(ofSize: 36)
      view.addSubview(elLabel)
      
      elTextField = UITextField()
      elTextField.placeholder = "Insert text"
      elTextField.layer.borderWidth = 1
      elTextField.layer.cornerRadius = 6
      elTextField.textAlignment = .center
      elTextField.font = UIFont.systemFont(ofSize: 24)
      view.addSubview(elTextField)
      
      hotelLabel = UILabel()
      hotelLabel.text = "Hotel"
      hotelLabel.textColor = backgroundOrange
      hotelLabel.font = UIFont.systemFont(ofSize: 36)
      view.addSubview(hotelLabel)
      
      hotelTextField = UITextField()
      hotelTextField.placeholder = "Insert text"
      hotelTextField.layer.borderWidth = 1
      hotelTextField.layer.cornerRadius = 6
      hotelTextField.textAlignment = .center
      hotelTextField.font = UIFont.systemFont(ofSize: 24)
      view.addSubview(hotelTextField)
      
      saveButton = UIButton()
      saveButton.setTitle("Save", for: .normal)
      saveButton.setTitleColor(UIColor(red: 200/255, green: 45/255, blue: 35/255, alpha: 1), for: .normal)
      saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 60)
      saveButton.layer.cornerRadius = 6
      //saveButton.backgroundColor = orange2
      saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
      view.addSubview(saveButton)
      
      dButton = UIButton()
      dButton.setTitle("Cancel", for: .normal)
      dButton.setTitleColor(UIColor(red: 200/255, green: 45/255, blue: 35/255, alpha: 1), for: .normal)
      dButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
      dButton.layer.cornerRadius = 6
      //dButton.backgroundColor = orange2
      dButton.addTarget(self, action: #selector(dButtonPressed), for: .touchUpInside)
      view.addSubview(dButton)
      
      warningLabel = UILabel()
      warningLabel.text = "All entries must be filled"
      warningLabel.textColor = .red
      warningLabel.isHidden = true
      warningLabel.font = UIFont.systemFont(ofSize: 16)
      view.addSubview(warningLabel)
      
      
      
      
      setupConstraints()
   }
   
   func setupConstraints() {
      slLabel.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
      }
      
      
      
      elLabel.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(slTextField.snp.bottom).offset(24)
      }
      
      
      
      hotelLabel.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(elTextField.snp.bottom).offset(24)
      }
      
      slTextField.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(slLabel.snp.bottom).offset(8)
         make.width.equalToSuperview().offset(-80)
      }
      
      
      
      elTextField.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(elLabel.snp.bottom).offset(8)
         make.width.equalToSuperview().offset(-80)
      }
      
      
      hotelTextField.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(hotelLabel.snp.bottom).offset(8)
         make.width.equalToSuperview().offset(-80)
      }
      
      saveButton.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.bottom.equalTo(dButton.snp.top).offset(8)
         make.width.equalTo(0).offset(saveButton.intrinsicContentSize.width + 16)
         //make.height.equalTo(0).offset(saveButton.intrinsicContentSize.height - 8)
      }
      
      dButton.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
         make.width.equalTo(0).offset(dButton.intrinsicContentSize.width + 8)
         //make.height.equalTo(0).offset(dButton.intrinsicContentSize.height - 4)
      }
      
      tripType.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(tripTypeLabel.snp.bottom).offset(8)
      }
      
      tripTypeLabel.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(hotelTextField.snp.bottom).offset(24)
      }
      
      warningLabel.snp.makeConstraints { make in
         make.bottom.equalTo(saveButton.snp.top).offset(4)
         make.centerX.equalToSuperview()
      }
      
      pickStartDateButton.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(tripType.snp.bottom).offset(24)
         make.width.equalTo(0).offset(pickStartDateButton.intrinsicContentSize.width + 8)
      }
      
      pickEndDateButton.snp.makeConstraints { make in
         make.centerX.equalToSuperview()
         make.top.equalTo(pickStartDateButton.snp.bottom).offset(8)
         make.width.equalTo(0).offset(pickEndDateButton.intrinsicContentSize.width + 8)
      }
   }
   
   @objc func saveButtonPressed(sender: UIButton) {
      let trip = Trip(startLocation: slTextField.text!, endLocation: elTextField.text!, startDate: startDate, endDate: endDate, hotel: hotelTextField.text!, id: 1, tripType: useType)
      
      if trip.startLocation.count > 0, trip.endLocation.count > 0, trip.hotel.count > 0 {
         warningLabel.isHidden = true
         delegate?.makeNewTrip(trip: trip)
         dismiss(animated: true, completion: nil)
      }
      else {
         warningLabel.isHidden = false
      }
   }
   
   @objc func dButtonPressed(sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   func printTrip(trip: Trip) {
      print("sl: \(trip.startLocation)")
   }
   
   @objc func tripTypeChanged() {
      
      if tripType.selectedSegmentIndex == 0 {
         self.useType = .car
      } else {
         self.useType = .plane
      }
   }
   
   @objc func pickStartDateButtonPressed() {
      let newVC = UpdatedCalendarViewController()
      newVC.delegate = self
      newVC.pickingStartDate = true
      present(newVC, animated: true)
   }
   
   @objc func pickEndDateButtonPressed() {
      let newVC = UpdatedCalendarViewController()
      newVC.delegate = self
      newVC.pickingStartDate = false
      present(newVC, animated: true)
   }
   
   @objc func pickHotelButtonPressed() {
      //let pickHotelVC = PickHotelViewController()
      //present(pickHotelVC, animated: true)
   }
   
}
