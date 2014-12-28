//
//  JKJokeCommentCell.m
//  Joke
//
//  Created by 赖隆斌 on 14/12/28.
//  Copyright (c) 2014年 赖隆斌. All rights reserved.
//

#import "JKJokeCommentCell.h"
#import "UIImageView+Util.h"

@interface JKJokeCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;
@property (strong, nonatomic) UILabel * contentLabel;

@property (nonatomic, strong) JKJokeCommentModel * jokeCommentModel;

@end

@implementation JKJokeCommentCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 66, screenWidth - 23, 21)];
    self.contentLabel.font = [UIFont systemFontOfSize:15.0f];
    self.contentLabel.numberOfLines = 0;
    
    [self addSubview:self.contentLabel];
}

- (void)initCellWithJokeCommentModel:(JKJokeCommentModel *)jokeCommentModel
{
    self.jokeCommentModel = jokeCommentModel;
    
    [self.userImageView setImageWithURL:[self.jokeCommentModel.user iconURL] placehold:[UIImage imageNamed:@"avatar.jpg"]];
    self.userNameLabel.Text = self.jokeCommentModel.user.login == nil ? @"匿名" : self.jokeCommentModel.user.login;
    self.contentLabel.text = self.jokeCommentModel.content;
    self.floorLabel.text = [NSString stringWithFormat:@"%ld楼", self.jokeCommentModel.floor];
    self.publishDateLabel.text = [self.jokeCommentModel.user createAtDateString];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect contentLabelFrame = self.contentLabel.frame;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat contentHeight = [JKJokeCommentCell contentHeightWithFont:[UIFont systemFontOfSize:15.0f] width:(screenSize.width - 23) string:self.jokeCommentModel.content];
    
    contentLabelFrame.size.height = contentHeight;
    contentLabelFrame.size.width = screenSize.width - 23;
    
    self.contentLabel.frame = contentLabelFrame;
}

+ (CGFloat)cellHeightWithJokeModel:(JKJokeCommentModel *)jokeCommentModel
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat contentHeight = [JKJokeCommentCell contentHeightWithFont:[UIFont systemFontOfSize:15.0f] width:(screenWidth - 23) string:jokeCommentModel.content];
    
    return 92 + contentHeight;
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

@end
