//
//  FeedObject.h
//  LentaClientSampleApp
//
//  Created by Vladimir Malakhov on 15.03.17.
//  Copyright © 2017 Vladimir Malakhov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedObject : NSObject

@property (nonatomic, strong) NSArray *title;
@property (nonatomic, strong) NSArray *image;
@property (nonatomic, strong) NSArray *urlContent;

- (instancetype) initFeedWithTitle:(NSArray *)title image:(NSArray *)image urlContent:(NSArray *)urlContent;

@end
