//
//  ViewController.m
//  LFY_TransitionExample
//
//  Created by IOS.Mac on 17/1/20.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//


#import "ViewControllerA.h"
#import "MyCustomCell.h"



@interface ViewControllerA ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collecionView;
@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    // Do any additional setup after loading the view, typically from a nib.
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


#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:kMyCustomCellID forIndexPath:indexPath];
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [(MyCustomCell *)cell configureCellWithPostURL:[NSString stringWithFormat:@"thing0%ld.jpg",(long)indexPath.row+1]];
}

@end
