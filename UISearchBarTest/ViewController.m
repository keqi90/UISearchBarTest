//
//  ViewController.m
//  UISearchBarTest
//
//  Created by keqi on 16/6/15.
//  Copyright © 2016年 keqi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate>
{
    NSMutableArray *_dataArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataArr = [NSMutableArray array];
    
    for (int i = 0; i < 26; i++) {
        NSString *alphaStr = [NSString stringWithFormat:@"Test %c%c",i + 'a', i+'A'];
        [_dataArr addObject:alphaStr];
    }
    NSLog(@"dataArr: %@", _dataArr);
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;   {
    NSLog(@"%s", __func__);

    //初始化展示搜索结果的控制器
    if (!_searchResultVC) {
        _searchResultVC = [[SearchResultViewController alloc] init];
        _searchResultVC.view.frame = CGRectMake(0, CGRectGetMaxY(searchBar.frame), searchBar.frame.size.width, self.view.frame.size.height - CGRectGetHeight(searchBar.frame) - 49 - 20);
    }
    [self.view addSubview:_searchResultVC.view];
    
    //清空数据源
    if (self.searchResultVC.resultArray.count) {
        [self.searchResultVC.resultArray removeAllObjects];
    }
    [self.searchResultVC.tableView reloadData];
    
    //选中某一行后的回调
    self.searchResultVC.DidSelectCellBlock = ^(NSString *str) {
        NSLog(@"选中了 %@", str);
        [searchBar resignFirstResponder];
    };
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;  {
    NSLog(@"%s", __func__);

    searchBar.text = @"";
    
    [self.searchResultVC.view removeFromSuperview];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText; {
    
    NSLog(@"%s", __func__);
    
    if (searchText.length == 0) {
        [self.searchResultVC.resultArray removeAllObjects];
        [self.searchResultVC.tableView reloadData];
        return;
    }
    
    for (NSString *str in _dataArr) {
        
        if ([str rangeOfString:searchText options:NSCaseInsensitiveSearch].location != NSNotFound) {
            
            [self.searchResultVC.resultArray addObject:str];
        }
    }
    [self.searchResultVC.tableView reloadData];

    
}// called when text changes (including clear)

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); {
    NSLog(@"%s", __func__);

    if (self.searchResultVC.resultArray.count) {
        [self.searchResultVC.resultArray removeAllObjects];
    }
    
    return YES;
    
}// called before text changes

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; {
    
    [searchBar resignFirstResponder];
    
}// called when cancel button pressed


@end
