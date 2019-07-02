//
//  ViewController.swift
//  GoogleSampleAd
//
//  Created by John Liedtke on 7/2/19.
//  Copyright © 2019 Walmart. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical

        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let bannerView = DFPBannerView(adSize: kGADAdSizeFluid)
        bannerView.rootViewController = self
        bannerView.adUnitID = "/55875582/WMUS-AppIOS/storeMode"
        bannerView.delegate = self
        bannerView.adSizeDelegate = self
        stackView.addArrangedSubview(bannerView)

        // Note: Issue can also be reproduced without use of a `UIStackView`. See below for an example. (must also
        // comment out `UIStackView` related code)
        /*
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)

        NSLayoutConstraint.activate([
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
         */

        let request = DFPRequest()
        request.customTargeting = ["location": "exposeapp", "ptype": "storemode"]

        bannerView.load(request)
    }
}

extension ViewController: GADAdSizeDelegate {

    func adView(_ bannerView: GADBannerView, willChangeAdSizeTo size: GADAdSize) {
        // Notice we receive a height of 0 and then 1... and then nothing else
        print("willChangeAdSizeTo size=\(size)")
    }
}

extension ViewController: GADBannerViewDelegate {

    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("bannerViewDidFailToReceiveAdWithError error=\(error.localizedDescription)")
    }
}
