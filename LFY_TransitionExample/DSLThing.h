//
//  DSLThing.h
//  LFY_TransitionExample
//
//  Created by IOS.Mac on 17/1/20.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSLThing : NSObject
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy, readonly) NSString *overview;

+ (NSArray*)exampleThings;

- (instancetype)initWithTitle:(NSString*)title image:(UIImage*)image overview:(NSString*)overview;

@end
