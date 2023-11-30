//
//  Checkers.swift
//  CheckersProject
//
//  Created by Ivan Klishevich on 13.08.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum CheckersColor: Int {
    case white = 0
    case black = 1
}

class Checkers: UIViewController{
    
    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var resultsBtn: UIButton!
    
//    @IBOutlet weak var timerSwitch: UISwitch!

    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var whoStepImage: UIImageView!
    @IBOutlet weak var whoStepView: UIView!
    @IBOutlet weak var whoStepLabel: UILabel!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var collectionTheme: CustomSettingsView!
    @IBOutlet weak var playersNames: CustomPlayersNameAlert!

    let clearAllButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Chalkduster", size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Clear All", for: .normal)
        button.isHidden = true
        return button
    }()

    let sortButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Chalkduster", size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Sort", for: .normal)
        button.isHidden = true
        return button
    }()
    
    var chessboard: UIView!
    var frameChessboard: UIImageView!
    var defaultCell: UIView?
    var isLong = false
    var isFirstStep = true
    var resumeGame: Bool = true
    var whoStep: CheckersColor = .white
    var cellAndChecker: [CheckerInfo] = []
    var possibleSteps: [Int] = []
    var beatPositions: [[Int]] = []
    var beatSteps: [[Int]] = []
    var kingCheckers: [Int] = []
    var kingBeatPositions: [[Int]] = []
    var kingBeatSteps: [[Any]] = []
    var doubleStep: [Any] = [false, -1]
    
    var dynamicChecker: [[Int]] = []
    var dynamicKingChecker: [[Any]] = []
    
    let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let ud = UserDefaults.standard
    
    var timer: CADisplayLink?
    var seconds: Int = 0
    var timerLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    var dataDate: String = ""
    
    var theme: Theme = Theme()
    var themes: [Theme] = []
    var background: UIImageView?
    
    var players: [Player] = []
    var results = [Results_m]()
    var resultsCopy = [Results_m]()
    var isResultsOriginal = true

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkSaveFile()
        setupStyle()
        addDBButtons()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
