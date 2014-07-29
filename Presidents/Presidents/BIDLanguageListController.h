//
//  BIDLanguageListController.h
//  Presidents
//
//  Created by Dexter Launchlabs on 7/29/14.
//  Copyright (c) 2014 Dexter Launchlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BIDDetailViewController;
@interface BIDLanguageListController : UITableViewController
@property (weak, nonatomic) BIDDetailViewController *detailViewController; @property (strong, nonatomic) NSArray *languageNames;
@property (strong, nonatomic) NSArray *languageCodes;
@end
