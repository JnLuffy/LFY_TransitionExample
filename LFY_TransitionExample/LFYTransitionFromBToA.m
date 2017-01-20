//
//  LFYTransitionFromBToA.m
//  LFY_TransitionExample
//
//  Created by IOS.Mac on 17/1/20.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import "LFYTransitionFromBToA.h"
#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "MyCustomCell.h"

@implementation LFYTransitionFromBToA

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    ViewControllerB *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewControllerA *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //Get a snapshot of the image View
    UIView *imageSnapshot = [fromViewController.imageView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:fromViewController.imageView.frame fromView:fromViewController.imageView.superview];
    fromViewController.imageView.hidden = YES;
    
    //Get the Cell we'll animate to
    MyCustomCell *cell = [toViewController collectionViewCellForThing:fromViewController.thing];
    cell.imageView.hidden = YES;
    
    //Setup the inital View states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view]; //将ToViewController放到fromViewController下面
    [containerView addSubview:imageSnapshot];
    
    [UIView animateWithDuration:duration animations:^{
        // Fade out the source view controller
        fromViewController.view.alpha = 0.0;
        
        // Move the image view
        imageSnapshot.frame = [containerView convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    } completion:^(BOOL finished) {
        // Clean up
        [imageSnapshot removeFromSuperview];
        fromViewController.imageView.hidden = NO;
        cell.imageView.hidden = NO;
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

@end
