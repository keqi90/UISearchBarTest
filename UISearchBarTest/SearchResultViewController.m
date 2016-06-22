//
//  SearchResultViewController.m
//  SmartHome
//
//  Created by issuser on 15/12/14.
//  Copyright © 2015年 周秋阳. All rights reserved.
//

#import "SearchResultViewController.h"
#import "FriendModel.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _resultArray = [NSMutableArray array];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_resultArray.count==0) {
        return nil;
    }
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId ] ;
    }
    FriendModel *fr = _resultArray[indexPath.row];
    cell.textLabel.text = fr.nikeName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendModel *friend = _resultArray[indexPath.row];
    
    if (_DidSelectCellBlock) {
        
        self.DidSelectCellBlock(friend);
    }
    
    [self removeSearchVCFromParentViewController];

}

- (void)removeSearchVCFromParentViewController
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
