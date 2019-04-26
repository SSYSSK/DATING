#import "NTESSessionSendShopGoodsContentView.h"
#import "NTESSendGiftAttachment.h"
#import "UIView+SL.h"
#import "UIImage+Image.h"

NSString *const SendCustomWithGoodsClick = @"SendCustomWithGoodsClick";


@interface NTESSessionSendShopGoodsContentView()

//添加手势
@property (nonatomic,strong)UITapGestureRecognizer*top;


@end

@implementation NTESSessionSendShopGoodsContentView

- (instancetype)initSessionMessageContentView{
    self = [super initSessionMessageContentView];
    if (self) {
        self.opaque = YES;
        //点击自定义消息cell,添加手势
        self.top = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:self.top];
        self.headerImg =[[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.headerImg];
        self.nameLa =[[UILabel   alloc]initWithFrame:CGRectZero];
        _nameLa.font =[UIFont systemFontOfSize:13];
        _nameLa.numberOfLines =0;
        [self addSubview:self.nameLa];
        self.priceLa =[[UILabel alloc]initWithFrame:CGRectZero];
        _priceLa.font =[UIFont systemFontOfSize:12];
        _priceLa.textColor =[UIColor orangeColor];
        [self addSubview:self.priceLa];
    }
    return self;
}

#pragma mark - 点击手势
- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    if ([self.delegate respondsToSelector:@selector(onCatchEvent:)]) {
        NIMKitEvent *event = [[NIMKitEvent alloc] init];
        
        //添加自定义消息标识符
        event.eventName = SendCustomWithGoodsClick;
        event.messageModel = self.model;
        event.data = self;
        [self.delegate onCatchEvent:event];
    }
}

//赋值
- (void)refresh:(NIMMessageModel *)data{
    [super refresh:data];
    NIMCustomObject *customObject = (NIMCustomObject*)data.message.messageObject;
    id attachment = customObject.attachment;
    if ([attachment isKindOfClass:[NTESSendGiftAttachment class]]) {
        
        self.nameLa.text =[attachment nameLabel ];
        IMAGE_URL(self.headerImg,[attachment headerImage], @"header.jpg");
        self.priceLa.text =[attachment priceLabel];
        
    }
}
//自定义view元素控件坐标设置
- (UIImage *)chatBubbleImageForState:(UIControlState)state outgoing:(BOOL)outgoing{
    
    self.headerImg.frame = CGRectMake(7,8,54,54);
    self.nameLa.frame = CGRectMake(70,5,125,40);
    self.priceLa.frame = CGRectMake(70,50,70,15);
    
    //背景颜色
    return [UIImage imageWithColor:[UIColor whiteColor]];
}
