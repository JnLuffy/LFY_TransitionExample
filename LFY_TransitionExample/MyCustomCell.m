//
//  MyCustomCell.m
//  LFY_TransitionExample
//
//  Created by IOS.Mac on 17/1/20.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import "MyCustomCell.h"
NSString *const kMyCustomCellID = @"kMyCustomCellID";

@implementation MyCustomCell
- (void)prepareForReuse {
    [super prepareForReuse];
    _imageView.image = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    if (_imageView) {
        return;
    }
    
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imageView = ({
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.contentView addSubview:imageView];
        imageView.frame = CGRectMake(0, 0,ITEM_WIDTH,ITEM_WIDTH);
        
        imageView;
    });
    
    _titleLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        label.frame = CGRectMake(0, ITEM_WIDTH, ITEM_WIDTH, 50);
        label;
    });
}

#pragma mark - Public Method

- (void)configureCellWithDSLThing:(DSLThing *)thing {
    _imageView.image = thing.image;
    _titleLabel.text =  thing.title;
 
}

@end
