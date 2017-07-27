//
//  ShopCell.m
//  Beautiful
//
//  Created by S on 16/1/28.
//  Copyright © 2016年 B. All rights reserved.
//

#import "ShopCell.h"

@implementation ShopCell

- (void)awakeFromNib {
    // Initialization code
}

+ (ShopCell*)getInstanceWithNib
{
    ShopCell *cell = nil;
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"ShopCell" owner:nil options:nil];
    for(id obj in objs) {
        if([obj isKindOfClass:[ShopCell class]]){
            cell = (ShopCell *)obj;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setUI:(ProductVO*)aVO
{
    _currentVO = aVO;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:aVO.pic] placeholderImage:[UIImage imageNamed:@"default_marketing.png"]];
    _title.text = aVO.title;
    _perPrice.text = [NSString stringWithFormat:@"￥%@",aVO.price];
    if([aVO.isSelected boolValue])
        _selectIMG.image = [UIImage imageNamed:@"select.png"];
    else
        _selectIMG.image = [UIImage imageNamed:@"unselect.png"];
    _selectNum.text = aVO.buyNum;
}

- (void)setSelect:(BOOL)isSelect
{
    if(isSelect)
        _selectIMG.image = [UIImage imageNamed:@"select.png"];
    else
        _selectIMG.image = [UIImage imageNamed:@"unselect.png"];

}

- (float)getShopMoney
{
    float money = [_selectNum.text intValue]*[_perPrice.text floatValue];
    return money;
}

- (IBAction)plus:(id)sender
{
    int num = [_selectNum.text intValue];
    num +=1;
    [[NetWork shareInstance] ShopCarNumChange:[Utils readUnarchiveHistoryGoodsVOsAry].token CartId:_currentVO.productId BuyNum:num CallBack:^(BOOL isSucc, NSDictionary *info) {
        if(isSucc)
        {
            _selectNum.text = [NSString stringWithFormat:@"%i",num];
            if(_delegate&&[_delegate respondsToSelector:@selector(plus:Num:)])
                [_delegate plus:self Num:_selectNum.text];
        }
    } FailBack:^(NSError *error) {
        
    }];
}

- (IBAction)minus:(id)sender
{
    int num = [_selectNum.text intValue];
    if(num > 1)
    {
        num -=1;
        [[NetWork shareInstance] ShopCarNumChange:[Utils readUnarchiveHistoryGoodsVOsAry].token CartId:_currentVO.productId BuyNum:num CallBack:^(BOOL isSucc, NSDictionary *info) {
            if(isSucc)
            {
                _selectNum.text = [NSString stringWithFormat:@"%i",num];
                if(_delegate&&[_delegate respondsToSelector:@selector(plus:Num:)])
                    [_delegate plus:self Num:_selectNum.text];
            }
        } FailBack:^(NSError *error) {
            
        }];
    }
}

- (void)setEditMode:(BOOL)isEdit
{
    _selectNum.hidden = isEdit;
    _minusBtn.hidden = isEdit;
    _plusBtn.hidden = isEdit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
