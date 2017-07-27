//
//  CategoryChooseView.h
//  Beautiful
//
//  Created by Binge on 2017/6/23.
//  Copyright © 2017年 B. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSortVO.h"
#import "ProductCategoryVO.h"


typedef enum{
    ChooseType_category,
    ChooseType_sort,
} ChooseType;

@protocol CategoryChooseViewDelegate <NSObject>

-(void)CategoryChooseViewDidselectWithType:(ChooseType)type model:(id)model;

@end


@interface CategoryChooseView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray *modelAry;
@property (nonatomic, assign)ChooseType type;
@property (nonatomic, weak)id <CategoryChooseViewDelegate> delegate;



+(CategoryChooseView *)buildCategoryChooseViewWithType:(ChooseType)type modelAry:(NSArray *)ary;


@end
