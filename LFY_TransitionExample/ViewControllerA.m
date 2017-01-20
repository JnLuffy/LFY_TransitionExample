//
//  ViewController.m
//  LFY_TransitionExample
//
//  Created by IOS.Mac on 17/1/20.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//


#import "ViewControllerA.h"
#import "MyCustomCell.h"
#import "DSLThing.h"



@interface ViewControllerA ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collecionView;
@property (nonatomic, strong) NSArray *things;

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self loadData];
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
    
    self.collecionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collecionView.backgroundColor = [UIColor whiteColor];
    _collecionView.delegate = self;
    _collecionView.dataSource = self;
    [_collecionView registerClass:[MyCustomCell class] forCellWithReuseIdentifier:kMyCustomCellID];
    [self.view addSubview:_collecionView];
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

@end
