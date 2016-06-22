//
//  SearchResultViewController.h
//  UISearchBarTest
//
//  Created by issuser on 16/6/15.
//  Copyright © 2016年 keqi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchResultViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *resultArray;

@property (nonatomic, copy) void(^DidSelectCellBlock)(NSString *str);

@end
