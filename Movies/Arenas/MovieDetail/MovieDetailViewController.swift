
import UIKit

final class MovieDetailViewController: UIViewController, View {
    
    typealias Event = MovieDetailViewEvent
    typealias Command = MovieDetailPresenterCommand
    
    var eventListener: AnyEventListener<MovieDetailViewEvent>?
    var movieDetailDTO = [MovieDetailDTO]()
    
    @IBOutlet weak var collectionViewMovieDetail: UICollectionView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    var isFavorite = false
    var selectedId = UserDefaults.standard.integer(forKey: "movieId")
    
    
    let movieDetailCellId = "MovieDetailCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventListener?.handle(event: .viewDidLoad)
        self.isFavoriteMovie()
        self.configureDisplay()
        self.configureCell()
        
    }
    
    func handle(command: MovieDetailPresenterCommand) {
        switch command {
        case let .loadMovieDetail(movieDetail):
            self.appenendMovieDetail(movieDetail)
            
        case let .setLoadingViewVisibility(shouldShow):
            DispatchQueue.main.async {
                if shouldShow {
                    LoadingManager.shared.setLoadingVisibility(LoadingView.VisibilityType.show(onView: self.view))
                } else {
                    LoadingManager.shared.setLoadingVisibility(LoadingView.VisibilityType.hide)
                }
            }
            
        @unknown default:
            print("PresenterCommand should be handled at \(#function)")
        }
    }
    
    convenience init() {
        self.init(nibName: "\(MovieDetailViewController.self)", bundle: nil)
    }
    
    private func appenendMovieDetail(_ movieDetail: MovieDetailDTO){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03, execute: {
            self.movieDetailDTO.append(movieDetail)
            self.collectionViewMovieDetail.reloadData()
            
        })
    }
    
    @IBAction func buttonBackAction(_ sender: UIButton) {
        self.eventListener?.handle(event: .backAction)
    }
    
    @IBAction func buttonFavoriteAction(_ sender: Any) {
        self.isFavorite.toggle()
        let imageName = self.isFavorite ? "movie_page_filled_icon" : "movie_page_empty_icon"
        
        UserDefaults.standard.set(self.isFavorite, forKey: "movieId\(self.selectedId)")
        UserDefaults.standard.set(self.selectedId, forKey: "selectedMovieId\(self.selectedId)")
        
        if self.isFavorite == false{
            UserDefaults.standard.removeObject(forKey: "selectedMovieId\(self.selectedId)")
        }
        self.buttonFavorite.setImage(UIImage(named: imageName), for: .normal)
        self.collectionViewMovieDetail.reloadData()
    }
    
    private func isFavoriteMovie(){
        let status = UserDefaults.standard.bool(forKey:"movieId\(self.selectedId)")
        let imageName = status ? "movie_page_filled_icon" : "movie_page_empty_icon"
        self.buttonFavorite.setImage(UIImage(named: imageName), for: .normal)
    }
    
}

extension MovieDetailViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset : CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewMovieDetail.dequeueReusableCell(withReuseIdentifier: movieDetailCellId, for: indexPath)
        
        if let  cell = cell as? MovieDetailCell{
            for movieDetail in movieDetailDTO {
                cell.labelTitle.text = movieDetail.original_title
                cell.labelVote.text = "\(movieDetail.vote_average)"
                cell.labelDetail.text = movieDetail.overview
                cell.imageView.load(urlString: "http://image.tmdb.org/t/p/w185/\(movieDetail.backdrop_path)")
            }
        }
        return cell
    }
}

extension MovieDetailViewController {
    private func configureDisplay(){
        self.collectionViewMovieDetail.dataSource = self
        self.collectionViewMovieDetail.delegate = self
    }
    
    private func configureCell(){
        let nibCell = UINib(nibName: movieDetailCellId, bundle: nil)
        self.collectionViewMovieDetail.register(nibCell, forCellWithReuseIdentifier: movieDetailCellId)
    }
}
