//
//  LentaFeedTableView.m
//  LentaClientSampleApp
//
//  Created by Vladimir Malakhov on 15.03.17.
//  Copyright © 2017 Vladimir Malakhov. All rights reserved.
//

#import "LentaFeedTableView.h"
#import "AFNetworking.h"

@interface LentaFeedTableView () {
    
    FeedObject *feed;
    
    NSUInteger indexCellForSelectSetHight;
    NSUInteger indexCellForSelectGetContent;
    
    NSArray *contentData;
    
    bool isSelected;
}

@end

@implementation LentaFeedTableView

@synthesize FeedTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLaunchSetting];
    [self ApplyStyleTableView];
    
    [self loadListFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) setLaunchSetting {
    
    indexCellForSelectSetHight = - 1;
}

- (void) ApplyStyleTableView {
    
    FeedTableView.rowHeight = UITableViewAutomaticDimension;
    FeedTableView.estimatedRowHeight = 50;
}

- (void) loadListFeed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://api.lenta.ru/lists/latest" parameters:nil progress:nil
     
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 
             feed = [[FeedObject alloc] initFeedWithTitle:[[[responseObject valueForKey:@"headlines"] valueForKey:@"info"] valueForKey:@"title"]
                                                    image:[[[responseObject valueForKey:@"headlines"] valueForKey:@"title_image"] valueForKey:@"url"]
                                               urlContent:[[[responseObject valueForKey:@"headlines"] valueForKey:@"links"] valueForKey:@"self"]
                   
                     ];
             [self.tableView reloadData];
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error: %@", error);
         }];
                                
}
- (void) loadContentData {
    
     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     [manager GET:@"https://api.lenta.ru/lists/latest" parameters:nil progress:nil
   
        success:^(NSURLSessionTask *task, id responseObject) {
     
     contentData = [[[responseObject valueForKey:@"headlines"] valueForKey:@"info"] valueForKey:@"rightcol"];
            
            NSLog(@"Content Data is %@", contentData);
            
     [self.tableView reloadData];

    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feed.title.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == indexCellForSelectSetHight)
        return UITableViewAutomaticDimension;
    else
        return 80;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedCell *cell = (FeedCell *)[FeedTableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FeedCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.title.text = [feed.title objectAtIndex:indexPath.row];
    cell.body.text = [[contentData objectAtIndex:0] description];
    
    if ([feed.image objectAtIndex:indexPath.row] == [NSNull null]) {
        cell.image.backgroundColor = [UIColor redColor];
    } else {
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[feed.image objectAtIndex:indexPath.row]]];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.image.image = image;
            });
        });
    }

    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
    if (isSelected == false) {
        
        indexCellForSelectSetHight = indexPath.row;
        [tableView beginUpdates];
        [tableView endUpdates];
        
        indexCellForSelectGetContent = indexPath.row;
        [self loadContentData];
        
        isSelected = true;
        
    } else {
        
        indexCellForSelectSetHight = - 1;
        [tableView beginUpdates];
        [tableView endUpdates];
        
        isSelected = false;
    }
}

@end
