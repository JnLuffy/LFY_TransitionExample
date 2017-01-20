//
//  ViewController.h
//  LFY_TransitionExample
//
//  Created by IOS.Mac on 17/1/20.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCustomCell.h"
@interface ViewControllerA : UIViewController
@property(nonatomic,strong)UICollectionView *collectionView;

- (MyCustomCell*)collectionViewCellForThing:(DSLThing*)thing;

@end

