//
//  MyCustomCell.h
//  LFY_TransitionExample
//
//  Created by IOS.Mac on 17/1/20.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const kMyCustomCellID;

@interface MyCustomCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;

- (void)configureCellWithPostURL:(NSString *)posterURL;

@end
