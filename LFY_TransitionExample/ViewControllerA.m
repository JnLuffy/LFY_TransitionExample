//
//  ViewController.m
//  LFY_TransitionExample
//
//  Created by IOS.Mac on 17/1/20.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//


#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "LFYTransitionFromAToB.h"
#import "MyCustomCell.h"
#import "DSLThing.h"



@interface ViewControllerA ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *things;

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self loadData];
}


-(void)viewWillAppear:(BOOL)animated{
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

- (void)createView{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(ITEM_WIDTH, ITEM_WIDTH+50);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[MyCustomCell class] forCellWithReuseIdentifier:kMyCustomCellID];
    [self.view addSubview:_collectionView];
}

- (void)loadData{
    _things = [DSLThing exampleThings];
    self.title = @"Things";
}


#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _things.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:kMyCustomCellID forIndexPath:indexPath];
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    DSLThing *thing = self.things[indexPath.row];
    [(MyCustomCell *)cell configureCellWithDSLThing:thing];
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    DSLThing *thing = self.things[indexPath.row];
    ViewControllerB *view = [ViewControllerB new];
    view.thing = thing;
    [self.navigationController pushViewController:view animated:YES];
    
}


#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLSecondViewController
    if (fromVC == self && [toVC isKindOfClass:[ViewControllerB class]]) {
        return [[LFYTransitionFromAToB alloc] init];
    }
    else {
        return nil;
    }
}


- (MyCustomCell*)collectionViewCellForThing:(DSLThing*)thing {
    NSUInteger thingIndex = [self.things indexOfObject:thing];
    if (thingIndex == NSNotFound) {
        return nil;
    }
    
    return (MyCustomCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:thingIndex inSection:0]];
}


@end
