import UIKit

class ViewController: UIViewController {
    
    private var compactConstraints: [NSLayoutConstraint] = []    // 컴팩트 가변을 보유
    private var regularConstraints: [NSLayoutConstraint] = []    // 일정한 변화를 유지
    private var sharedConstraints: [NSLayoutConstraint] = []     // 모든 다양한 공통 제약 조건
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var image1: UIImageView = {
        let image1 = UIImageView()
        image1.translatesAutoresizingMaskIntoConstraints = false
        image1.image = UIImage(named: "1")
        image1.contentMode = .scaleAspectFit
        return image1
    }()
    
    private lazy var image2: UIImageView = {
        let image2 = UIImageView()
        image2.translatesAutoresizingMaskIntoConstraints = false
        image2.image = UIImage(named: "2")
        image2.contentMode = .scaleAspectFit
        return image2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupConstraints()
        NSLayoutConstraint.activate(sharedConstraints)
        self.layoutTrait(traitCollection: UIScreen.main.traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if (self.traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass || self.traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass) {
            print("Device traitCollection이 변경됨")
        }

        switch traitCollection.horizontalSizeClass {
        case .compact:
              print("가로가 compact인 경우!")
        case .regular:
            print("가로가 regular인 경우!")
        case .unspecified:
            break
        @unknown default:
            break
        }

        switch traitCollection.verticalSizeClass {
        case .compact:
              print("세로가 compact인 경우!")
        case .regular:
            print("세로가 regular인 경우!")
        case .unspecified:
            break
        @unknown default:
            break
        }
    }
    
    func setupUI() {
        view.addSubview(viewContainer)
        view.addSubview(image1)
        view.addSubview(image2)
    }
    
    func setupConstraints() {
        sharedConstraints.append(contentsOf: [
            viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            viewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            viewContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),

            image1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image1.topAnchor.constraint(equalTo: view.topAnchor),
            image2.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        regularConstraints.append(contentsOf: [
            image1.trailingAnchor.constraint(equalTo: image2.leadingAnchor, constant: -10),
            image1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image2.topAnchor.constraint(equalTo: view.topAnchor),
        ])

        compactConstraints.append(contentsOf: [
            image1.bottomAnchor.constraint(equalTo: image2.topAnchor, constant: -10),
            image1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image2.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    func layoutTrait(traitCollection:UITraitCollection) {
        if (!sharedConstraints[0].isActive) {
           // activating shared constraints
           NSLayoutConstraint.activate(sharedConstraints)
        }
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            if regularConstraints.count > 0 && regularConstraints[0].isActive {
                NSLayoutConstraint.deactivate(regularConstraints)
            }
            // activating compact constraints
            NSLayoutConstraint.activate(compactConstraints)
        } else {
            if compactConstraints.count > 0 && compactConstraints[0].isActive {
                NSLayoutConstraint.deactivate(compactConstraints)
            }
            // activating regular constraints
            NSLayoutConstraint.activate(regularConstraints)
        }
    }


}

