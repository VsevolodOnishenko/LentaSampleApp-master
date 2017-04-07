//
//  FeedObject.m
//  LentaClientSampleApp
//
//  Created by Vladimir Malakhov on 15.03.17.
//  Copyright © 2017 Vladimir Malakhov. All rights reserved.
//

#import "FeedObject.h"

@implementation FeedObject

- (instancetype) initFeedWithTitle:(NSArray *)title image:(NSArray *)image urlContent:(NSArray *)urlContent {
    
    self = [super init];
    
    if (self) {
        
        self.title = title;
        self.image = image;
        self.urlContent = urlContent;
    }
    
    return self;
}

@end
