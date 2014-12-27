//
//  JKJokeCell.m
//  Joke
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import "JKJokeCell.h"
#import "UIImageView+Util.h"

@interface JKJokeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) UILabel * contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *upButton;
@property (weak, nonatomic) IBOutlet UIButton *downButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIImageView *jokeImageView;
@property (nonatomic, strong) JKJokeModel * jokeModel;

@end
@implementation JKJokeCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.jokeImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapImageGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageGesture:)];
    [self.jokeImageView addGestureRecognizer:tapImageGesture];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 66, screenWidth - 23, 21)];
    self.contentLabel.font = [UIFont systemFontOfSize:15.0f];
    self.contentLabel.numberOfLines = 0;
    
    [self addSubview:self.contentLabel];
}

- (void)initCellWithJokeModel:(JKJokeModel *)jokeModel
{
    self.jokeModel = jokeModel;
    
    [self.userIconImageView setImageWithURL:[self.jokeModel.user iconURL] placehold:[UIImage imageNamed:@"avatar.jpg"]];
    self.userNameLabel.text = self.jokeModel.user.login == nil ? @"匿名" : self.jokeModel.user.login;
    self.contentLabel.text = self.jokeModel.content;
    [self.jokeImageView setImageWithURL:[self.jokeModel smallImageURL]  placehold:nil];
    
    [self.upButton setTitle:[NSString stringWithFormat:@"顶(%ld)", self.jokeModel.votes.up] forState:UIControlStateNormal];
    [self.downButton setTitle:[NSString stringWithFormat:@"踩(%ld)", self.jokeModel.votes.down] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"评论(%ld)", self.jokeModel.commentCount] forState:UIControlStateNormal];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentLabelFrame = self.contentLabel.frame;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat contentHeight = [JKJokeCell contentHeightWithFont:[UIFont systemFontOfSize:15.0f] width:(screenSize.width - 23) string:self.jokeModel.content];
    
    contentLabelFrame.size.height = contentHeight;
    contentLabelFrame.size.width = screenSize.width - 23;
    
    self.contentLabel.frame = contentLabelFrame;
}

+ (CGFloat)cellHeightWithJokeModel:(JKJokeModel *)jokeModel
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat contentHeight = [JKJokeCell contentHeightWithFont:[UIFont systemFontOfSize:15.0f] width:(screenWidth - 23) string:jokeModel.content];
    
    if ((id)jokeModel.image != [NSNull null] && jokeModel.image != nil && [jokeModel.image isEqualToString:@""] == NO) {
        return 200 + contentHeight;
    } else {
        return 110 + contentHeight;
    }
}

+ (CGFloat)contentHeightWithFont:(UIFont *)font width:(CGFloat)width string:(NSString *)string
{
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary * attributes = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle};
    
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return rect.size.height;
}

- (void)tapImageGesture:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(showJokeImageAction:)]) {
        [self.delegate showJokeImageAction:self.jokeModel];
    }
}

@end
