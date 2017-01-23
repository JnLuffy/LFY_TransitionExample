//
//  ViewControllerB.m
//  LFY_TransitionExample
//
//  Created by IOS.Mac on 17/1/20.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import "ViewControllerB.h"
#import "LFYTransitionFromBToA.h"
#import "ViewControllerA.h"
@interface ViewControllerB ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UILabel *overviewLabel;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createView];
    
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer  alloc]initWithTarget:self action:@selector(handlerPopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
    
}


#pragma mark UIViewController methods

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set outself as the navigation controller's delegate so we're asked for a transitioning object
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Stop being the navigation controller's delegate
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createView{
    self.title = _thing.title;
    _imageView = [UIImageView new];
    _imageView.image =  _thing.image;
    _imageView.frame = CGRectMake((SCREEN_WIDTH-ITEM_WIDTH)/2, 30, ITEM_WIDTH, ITEM_WIDTH);
    [self.view addSubview:_imageView];
    
    _overviewLabel = [UILabel new];
    [self.view addSubview:_overviewLabel];
    _overviewLabel.textAlignment = NSTextAlignmentCenter;
    _overviewLabel.numberOfLines = 0;
    _overviewLabel.lineBreakMode = UILineBreakModeWordWrap;
    _overviewLabel.text = _thing.overview;
    CGSize size = [_overviewLabel sizeThatFits:CGSizeMake(ITEM_WIDTH, MAXFLOAT)];
    _overviewLabel.frame = CGRectMake(_imageView.frame.origin.x, 35+ITEM_WIDTH, ITEM_WIDTH, size.height);
    

    
}

#pragma mark UIGestureRecognizer handlers
-(void)handlerPopRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
    
}


#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLFirstViewController
    if (fromVC == self && [toVC isKindOfClass:[ViewControllerA class]]) {
        return [[LFYTransitionFromBToA alloc] init];
    }
    else {
        return nil;
    }
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    // Check if this is for our custom transition
    if ([animationController isKindOfClass:[LFYTransitionFromBToA class]]) {
        return self.interactivePopTransition;
    }
    else {
        return nil;
    }
}



@end
