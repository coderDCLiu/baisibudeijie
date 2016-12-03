//
//  LDCBaseViewController.m
//  BaiSiBuDeiJie
//
//  Created by 刘冬城 on 16/10/24.
//  Copyright © 2016年 刘冬城. All rights reserved.
//

#import "LDCBaseViewController.h"
#import "LDCBaseTableViewController.h"


static NSString * const ID = @"collection";

@interface LDCBaseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak,nonatomic) UIScrollView *scrollV;

@property (weak,nonatomic) UICollectionView *collectionV;

@property (weak,nonatomic) UIButton *selectedBtn;

@property (strong,nonatomic) NSMutableArray *btnArray;

@property (weak,nonatomic) UIView *underLine;

@property (assign,nonatomic) BOOL isInitial;

@end

@implementation LDCBaseViewController

-(NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置底部的占位视图view为collectionView
    [self setUpContainterView];
    
    //设置控制器按钮的父控件视图为scrollView
    [self setUpButtonView];
    
    // 取消自动添加额外滚动区域
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.isInitial == NO) {
        
        //添加标题按钮
        [self setUpTitleButton];
        self.isInitial = YES;
    }
    
}


//设置底部的占位视图view为collectionView
-(void)setUpContainterView
{
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc]init];
    flowL.itemSize = [UIScreen mainScreen].bounds.size;
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowL.minimumLineSpacing = 0;
    flowL.minimumInteritemSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowL];
//    collectionView.prefetchingEnabled = NO;
//    collectionView.scrollsToTop = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor redColor];
    self.collectionV = collectionView;
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    
    
}

//设置控制器按钮的父控件视图为scrollView
-(void)setUpButtonView
{
    CGFloat y = self.navigationController.navigationBarHidden==YES?20:64;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, y, LDCScreenW, 35)];
    scrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    self.scrollV = scrollView;
//    self.scrollV.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    
}

//添加标题按钮
-(void)setUpTitleButton
{
    NSUInteger i = self.childViewControllers.count;
    
    CGFloat btnW = LDCScreenW / i;
    CGFloat btnH = self.scrollV.ldc_height;
    
    for (int a = 0;a < i ; a++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =CGRectMake(a * btnW, 0, btnW, btnH);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = a;
        
        [button setTitle:self.childViewControllers[a].title forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollV addSubview:button];
        
        [self.btnArray addObject:button];
        
        [button.titleLabel sizeToFit];
        
        if (a == 0) {
            
            //添加按钮下面的滚动条
            UIView *underLine = [[UIView alloc]init];
            underLine.backgroundColor = [UIColor redColor];
            self.underLine = underLine;
            [button.titleLabel sizeToFit];
            [self.scrollV addSubview:underLine];
            
            underLine.ldc_width = button.titleLabel.ldc_width;
            underLine.ldc_height = 2;
            underLine.ldc_centerX = button.ldc_centerX;
            underLine.ldc_y = button.ldc_height - underLine.ldc_height;
            
            [self titleButtonClick:button];
        }
    }
}

//标题按钮的点击
-(void)titleButtonClick:(UIButton*)button
{
    NSUInteger i = button.tag;
    
    if (button == _selectedBtn) {
        LDCBaseTableViewController *VC = self.childViewControllers[i];
        [VC reload];
    }
    
    
    [self selectedButton:button];

    self.collectionV.contentOffset = CGPointMake(i * LDCScreenW, 0);
    
}

//标题按钮的选中状态
-(void)selectedButton:(UIButton*)button
{
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.ldc_centerX = button.ldc_centerX;
    }];
    
}

#pragma mark - collectionView的代理方法

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childViewControllers.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UITableViewController *vc = self.childViewControllers[indexPath.row];
    vc.tableView.contentInset = UIEdgeInsetsMake(64 + self.scrollV.ldc_height, 0, 49, 0);
    vc.view.frame = [UIScreen mainScreen].bounds;
    [cell.contentView addSubview:vc.view];
    
    
    return cell;
}

//滑动完成时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger i = scrollView.contentOffset.x / LDCScreenW;
    UIButton *btn = self.btnArray[i];
    [self selectedButton:btn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
