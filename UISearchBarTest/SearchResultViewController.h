//
//  SearchResultViewController.h
//  SmartHome
//
//  Created by issuser on 15/12/24.
//  Copyright © 2015年 周秋阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendModel;
@class SearchResultViewController;

@protocol SearchResultDelegate <NSObject>

//- (void)SearchResultViewController:(SearchResultViewController *)searchVC didSelectFriend:(FriendModel *)groupF;
@end

@interface SearchResultViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *resultArray;
//@property (nonatomic, copy) id<SearchResultDelegate>delegate;

@property (nonatomic, copy) void(^DidSelectCellBlock)(FriendModel *groupF);

- (void)removeSearchVCFromParentViewController;

@end
