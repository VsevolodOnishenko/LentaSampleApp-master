//
//  LentaFeedTableView.h
//  LentaClientSampleApp
//
//  Created by Vladimir Malakhov on 15.03.17.
//  Copyright © 2017 Vladimir Malakhov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FeedObject.h"
#import "FeedCell.h"

@interface LentaFeedTableView : UITableViewController <NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate, NSURLSessionDelegate>

@property (strong, nonatomic) IBOutlet UITableView *FeedTableView;

@end
