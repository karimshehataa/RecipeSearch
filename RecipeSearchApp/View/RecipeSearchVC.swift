//
//  RecipeSearchVC.swift
//  
//
//  Created by karim  on 03/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class RecipeSearchVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var recipTableView: UITableView!
    let viewModel:RecipeSearchViewModelProtocol
    let disposeBag = DisposeBag()
    private var searchText:String?
    var filterArr = ["All","low-sugar","dairy-free","vegan"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        registerCollectionView()
        registerTableView()
        subscribeToResponse()
        subscribeToRecipeSelected()
    }
    
    init(viewModel: RecipeSearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func registerTableView() {
        recipTableView.register(UINib(nibName: "RecipeCell", bundle: nil), forCellReuseIdentifier: "RecipeCell")
    }
    
    private func registerCollectionView() {
        filterCollectionView.register(UINib(nibName: "FilterCell", bundle: nil), forCellWithReuseIdentifier: "FilterCell")
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
    }
    
    func subscribeToResponse() {
        recipTableView.dataSource = nil
        viewModel.RecipeObservable.bind(to: recipTableView.rx.items(cellIdentifier: "RecipeCell", cellType: RecipeCell.self)) { [weak self] item , recipe , cell in
            guard let self = self else {return}
            print(item)
            let islast = self.recipTableView.isLast(for: IndexPath(row: item, section: 0))
            if islast{
                self.viewModel.getSearchRecipe(recipe: self.searchText ?? "", health: "", isPaginate: true, isFilter: false)
            }
            cell.recipeSource.text = recipe.recipe?.source
            cell.recipetitle.text = recipe.recipe?.label
            let url = URL(string: recipe.recipe?.image ?? "")
            cell.recipeImage.image = nil
            cell.recipeImage.af.setImage(withURL: url ?? URL(fileURLWithPath: ""))
        }.disposed(by: disposeBag)
    }
    
    func subscribeToRecipeSelected() {
        Observable.zip(recipTableView.rx.itemSelected, recipTableView.rx.modelSelected(Hit.self)).bind {[weak self] index, recipe in
            guard let self = self else {return}
            let viewModel = RecipeDetailsViewModel()
            let vc = RecipeDetailsVC(viewModel: viewModel)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                viewModel.recipe?(recipe)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
}

extension RecipeSearchVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCell", for: indexPath) as! FilterCell
        let filter = filterArr[indexPath.item]
        cell.filterName.text = filter
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(searchText)
        let filterName = filterArr[indexPath.item]
        if self.searchText?.isEmpty == false {
            print(filterName)
            viewModel.getSearchRecipe(recipe: searchText ?? "",health: filterName, isPaginate: false, isFilter: true)
        } else {
            print("search is empty!")
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

extension RecipeSearchVC:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        self.searchText = searchText
        viewModel.getSearchRecipe(recipe: searchText,health: "", isPaginate: false, isFilter: false)
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
       searchText = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        self.searchText = searchText
    }
}
