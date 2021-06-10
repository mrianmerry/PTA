//
//  PreliminaryLoadingViewController.swift
//  Pokemon Tabletop Adventure
//
//  Created by Ian Merryweather on 27/03/2019.
//  Copyright © 2019 Undersea Love. All rights reserved.
//

import UIKit

class PreliminaryLoadingViewController: UIViewController {
    required init?(coder aDecoder: NSCoder) { fatalError("No storyboards!") }

    weak var actionDelegate: ActionDelegate?
    
    private let appLogo = UIImageView(frame: .zero)
    private let loadingWarning = UILabel(frame: .zero)
    private let progressIndicator = UIProgressView(progressViewStyle: .default)
    private let viewModel: PreliminaryLoadable

    init(loadable viewModel: PreliminaryLoadable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1.0, animations: { [unowned self] in
            self.update(alpha: 1.0)
            }, completion: { [weak self] completed in
                if let self = self, completed {
                    self.loadInitialData()
                }
        })
    }
}

// MARK: - Functionality
private extension PreliminaryLoadingViewController {
    func loadInitialData() {
        let timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            self.incrementProgress()
        }

        let jsonQueue =  DispatchQueue(label: "json-loading-utility", qos: .utility)
        let main = DispatchQueue.main
        jsonQueue.async {
            Thread.sleep(forTimeInterval: 0.5)
            JSON.setupPokedexCache { [weak self] in
                guard let self = self else { return }
                self.loadingWarning.updateAttributedText(LoadingMessage.valueAnalysingPokedex)

                // simulating getting other cached data stores ready:
                jsonQueue.async {
                    Thread.sleep(forTimeInterval: 1)
                    main.async { self.loadingWarning.updateAttributedText(LoadingMessage.valueInformingTeamRocket) }
                }

                jsonQueue.async {
                    Thread.sleep(forTimeInterval: 0.5)
                    main.async { self.loadingWarning.updateAttributedText(LoadingMessage.valueThanksForWaiting) }
                }

                jsonQueue.async {
                    Thread.sleep(forTimeInterval: 0.5)
                    main.async { self.finishProgress(invalidating: timer) }
                }
            }
        }
    }

    func incrementProgress() {
        let newProgress = progressIndicator.progress + 0.01
        progressIndicator.setProgress(min(newProgress, 1), animated: true)
        guard progressIndicator.progress >= 1.0 else { return }
        progressIndicator.loop()
    }

    func finishProgress(invalidating timer: Timer) {
        timer.invalidate()
        progressIndicator.isHidden = true
        loadingWarning.isHidden = true
        actionDelegate?.respondToAction(.preliminaryLoadingCompleted)
    }
}

// MARK: Setup
private extension PreliminaryLoadingViewController {
    func setupViews() {
        view.backgroundColor = .logo
        setupAppLogo()
        setupProgress()
        setupWarning()
        update(alpha: 0.0)
    }

    func setupAppLogo() {
        view.addSubview(appLogo)

        appLogo.translatesAutoresizingMaskIntoConstraints = false
        appLogo.contentMode = .scaleAspectFit
        appLogo.image = UIImage(named: "launch")
        let layoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [appLogo.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
             appLogo.centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor, constant: -100),
             appLogo.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.9),
             appLogo.heightAnchor.constraint(equalTo: appLogo.widthAnchor)]
        )
    }

    func setupProgress() {
        view.addSubview(progressIndicator)

        progressIndicator.setProgress(0, animated: false)
        progressIndicator.progressTintColor = .white
        progressIndicator.trackTintColor = view.backgroundColor
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false

        let layoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate(
            [progressIndicator.centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
             progressIndicator.topAnchor.constraint(equalTo: appLogo.bottomAnchor, constant: 44),
             progressIndicator.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.8)]
        )
    }

    func setupWarning() {
        view.addSubview(loadingWarning)

        loadingWarning.numberOfLines = 0
        loadingWarning.translatesAutoresizingMaskIntoConstraints = false
        loadingWarning.attributedText = NSAttributedString(string: LoadingMessage.valueInitialisingPokedex,
                                                           attributes: [.paragraphStyle: NSParagraphStyle.centered,
                                                                        .foregroundColor: UIColor.white])

        NSLayoutConstraint.activate(
            [loadingWarning.centerXAnchor.constraint(equalTo: progressIndicator.centerXAnchor),
             loadingWarning.widthAnchor.constraint(equalTo: progressIndicator.widthAnchor),
             loadingWarning.topAnchor.constraint(equalTo: progressIndicator.bottomAnchor, constant: 8)]
        )
    }

    func update(alpha: CGFloat) {
        progressIndicator.alpha = alpha
        loadingWarning.alpha = alpha
    }

    private enum LoadingMessage: String {
        case initialisingPokedex = "Booting up Pokedex..."
        case analysingPokemon = "Analysing Pokemon..."
        case informingTeamRocket = "Informing Team Rocket..."
        case thanksForWaiting = "Thank you for waiting patiently!"

        static var valueInitialisingPokedex: String { return initialisingPokedex.rawValue }
        static var valueAnalysingPokedex: String { return analysingPokemon.rawValue }
        static var valueInformingTeamRocket: String { return informingTeamRocket.rawValue }
        static var valueThanksForWaiting: String { return thanksForWaiting.rawValue }
    }
}
