//
//  SearchTableViewController.m
//  UISearchBarTest
//
//  Created by keqi on 16/6/21.
//  Copyright © 2016年 keqi. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()<UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic, strong) UISearchController *searchController;
/**
 *  搜索的数据源
 */
@property (nonatomic, strong) NSMutableArray *sourceDataArray;
/**
 *  搜索结果
 */
@property (nonatomic, strong) NSMutableArray *searchResultArray;
@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

    [self initSearchController];
}

- (void)initSearchController {
    //传nil表示 搜索结果会展示在当前Controller的View
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.delegate = self;  //可以省略
    searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController = searchController;  //必须强引用
    
    //添加搜索框
    self.tableView.tableHeaderView = searchController.searchBar;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.searchResultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    cell.textLabel.text = self.searchResultArray[indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *selectedStr = self.searchResultArray[indexPath.row];
    NSLog(@"%@", selectedStr);
    
    [self.searchController.searchBar resignFirstResponder];
}



#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    [self filterDataWithSearchText:searchController.searchBar.text];
    [self.tableView reloadData];
}

- (void)filterDataWithSearchText:(NSString *)searchText {
    NSLog(@"%@",searchText);
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    [self.searchResultArray removeAllObjects];
    for (int i = 0; i < self.sourceDataArray.count; i++) {
        NSString *title = self.sourceDataArray[i];
        NSRange storeRange = NSMakeRange(0, title.length);
        NSRange foundRange = [title rangeOfString:searchText options:searchOptions range:storeRange];
        if (foundRange.length) {
            [self.searchResultArray addObject:title];
        }
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;  {
    NSLog(@"%s", __func__);
    
    searchBar.text = @"";
}

#pragma mark - Lazy Loading

- (NSMutableArray *)sourceDataArray{
    if (!_sourceDataArray) {
        _sourceDataArray = [NSMutableArray array];
        for (int i = 1; i < 20 ; i ++) {
            NSString *str = [NSString stringWithFormat:@"Test %d",i];
            [self.sourceDataArray addObject:str];
        }
    }
    return _sourceDataArray;
}

- (NSMutableArray *)searchResultArray{
    if (!_searchResultArray) {
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}

@end
