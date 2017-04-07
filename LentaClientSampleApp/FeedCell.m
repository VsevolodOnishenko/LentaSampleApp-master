//
//  FeedCell.m
//  LentaClientSampleApp
//
//  Created by Vladimir Malakhov on 16.03.17.
//  Copyright © 2017 Vladimir Malakhov. All rights reserved.
//

#import "FeedCell.h"

@implementation FeedCell

@synthesize image = _image;
@synthesize title = _title;
@synthesize body = _body;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    if (selected) {
        _body.hidden = true;
    } else {
        _body.hidden = false;
    }
}

@end
