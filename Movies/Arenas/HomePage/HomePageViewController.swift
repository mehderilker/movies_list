
import UIKit

final class HomePageViewController: UIViewController, View {
    
    typealias Event = HomePageViewEvent
    typealias Command = HomePagePresenterCommand
    
    var eventListener: AnyEventListener<HomePageViewEvent>?
    
    @IBOutlet weak var collectionViewHomePage: UICollectionView!
    @IBOutlet weak var buttonListOrGridView: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var moviesDTO = [MoviesResultsDTO]()
    var filteredMovies = [MoviesResultsDTO]()
    
    var isLoading = true
    var isSearching = false
    var loadingView: HomePageReusableView?
    var selectedId = UserDefaults.standard.integer(forKey: "movieId")
    var isListView = UserDefaults.standard.bool(forKey:"isShowListView")
    
    let apiService = MoviesApiService()
    let homePageListViewCellId = "HomePageListViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventListener?.handle(event: .viewDidLoad)
        self.setListOrGridIcon()
        self.configureDisplay()
        self.configureCell()
    }
    
    func handle(command: HomePagePresenterCommand) {
        switch command {
        case let .loadMovies(movies):
            self.loadMovies(movies.results)
            
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
        self.init(nibName: "\(HomePageViewController.self)", bundle: nil)
    }
    
    private func loadMovies(_ movies : [MoviesResultsDTO]){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03, execute: {
            self.moviesDTO.append(contentsOf: movies)
            self.collectionViewHomePage.reloadData()
        })
    }
    
    private func  loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                // Service Request
                DispatchQueue.main.async {
                    self.collectionViewHomePage.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
    @IBAction func buttonListOrGridAction(_ sender: Any) {
        self.isListView.toggle()
        let imageName = self.isListView ? "home_page_grid_view_icon" : "home_page_list_view_icon"
        
        UserDefaults.standard.set(self.isListView, forKey: "isShowListView")
        
        self.buttonListOrGridView.setImage(UIImage(named: imageName), for: .normal)
        self.collectionViewHomePage.reloadData()
    }
    
    private func setListOrGridIcon(){
        let status = UserDefaults.standard.bool(forKey:"isShowListView")
        let imageName = status ? "home_page_grid_view_icon" : "home_page_list_view_icon"
        self.buttonListOrGridView.setImage(UIImage(named: imageName), for: .normal)
        self.collectionViewHomePage.reloadData()
    }
    
    private func isFavoriteIcon(movieId: Int) -> Bool{
        if movieId == UserDefaults.standard.integer(forKey:"selectedMovieId\(movieId)") {
            return false
        }else {
            return true
        }
    }
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.isSearching {
            return self.filteredMovies.count
        }
        return self.moviesDTO.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset : CGFloat = 0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let status = UserDefaults.standard.bool(forKey:"isShowListView")
        
        let cellSize = status ? CGSize(width: UIScreen.main.bounds.width, height: 140) : CGSize(width: UIScreen.main.bounds.width / 2.2, height: 140)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewHomePage.dequeueReusableCell(withReuseIdentifier: homePageListViewCellId, for: indexPath)
        
        if let cell = cell as? HomePageListViewCell {
            for i in 0...indexPath.item{
                
                if self.isSearching {
                    cell.imageViewFavorite.isHidden = self.isFavoriteIcon(movieId: filteredMovies[i].id)
                    cell.labelTitle.text = filteredMovies[i].title
                    cell.imageView.load(urlString: "http://image.tmdb.org/t/p/w185/\(filteredMovies[i].poster_path)")
                }else {
                    cell.imageViewFavorite.isHidden = self.isFavoriteIcon(movieId: moviesDTO[i].id)
                    cell.labelTitle.text = moviesDTO[i].title
                    cell.imageView.load(urlString: "http://image.tmdb.org/t/p/w185/\(moviesDTO[i].poster_path)")
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingresuableviewid", for: indexPath) as! HomePageReusableView
            self.loadingView = aFooterView
            self.loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.moviesDTO.count - 10 && !self.isLoading {
            loadMoreData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.isSearching {
            UserDefaults.standard.set(filteredMovies[indexPath.row].id, forKey: "movieId")
            self.eventListener?.handle(event: .openDetailPage(movieId: filteredMovies[indexPath.row].id))
        }else{
            UserDefaults.standard.set(moviesDTO[indexPath.row].id, forKey: "movieId")
            self.eventListener?.handle(event: .openDetailPage(movieId: moviesDTO[indexPath.row].id))
        }
    }
}

extension HomePageViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearching = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.isSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchBar.text) -- \(searchText)")
        self.filteredMovies.removeAll(keepingCapacity: false)
        let predicateString = searchBar.text!
        self.filteredMovies = self.moviesDTO.filter({
            $0.title.range(of: predicateString) != nil
        })
        
        self.isSearching = (self.filteredMovies.count == 0) ? false : true
        self.collectionViewHomePage.reloadData()
    }
    
}

extension HomePageViewController{
  
    private func configureDisplay(){
        self.collectionViewHomePage.dataSource = self
        self.collectionViewHomePage.delegate = self
        self.searchBar.delegate = self
    }
    
    private func configureCell(){
        let nibCell = UINib(nibName: homePageListViewCellId, bundle: nil)
        self.collectionViewHomePage.register(nibCell, forCellWithReuseIdentifier: homePageListViewCellId)
        
        let loadingReusableNib = UINib(nibName: "LoadingReusableView", bundle: nil)
        collectionViewHomePage.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loadingresuableviewid")
        
    }
}
