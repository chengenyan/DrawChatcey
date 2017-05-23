#import "AFView.h"
#import "AFDescribeObj.h"
@implementation AFView
{
    CGFloat w;
    CGFloat h;
    CGFloat widthspec;
    CGFloat heightspec;
}
@synthesize min_Y;
@synthesize max_Y;
@synthesize min_X;
@synthesize max_X;
@synthesize data;
@synthesize x_labels;
@synthesize y_labels;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        w = frame.size.width;
        h = frame.size.height;
        widthspec=w/10;
        heightspec=h/10;
        self.backgroundColor = [UIColor lightGrayColor];
        self.layer.cornerRadius = w*0.05;
    }
    return self;
}

- (void)setData:(NSArray *)_data
{
    data = [NSArray arrayWithArray:_data];
    
    [self addAXis];

    CGFloat startTime = 2.0f;
    for (int i=1; i<data.count; i++)
    {
        CGPoint s = [data[i-1] CGPointValue];
        CGPoint e = [data[i] CGPointValue];
        
        s.x = (s.x - min_X)*0.85*w/(max_X - min_X+1) + 0.1*w ;
        s.y = 0.9*h - (s.y - min_Y)*0.8*h/(max_Y - min_Y);
        e.x = (e.x - min_X)*0.85*w/(max_X - min_X+1) + 0.1*w ;
        e.y = 0.9*h - (e.y - min_Y)*0.8*h/(max_Y - min_Y);
        
        AFDescribeObj *desObj = [[AFDescribeObj alloc]
                                 initWithType:AFAnimationStrokeEnd inView:self];
        [desObj setStartTime:startTime andDuration:0.5f];
        [desObj addLineFrom:s toPoint:e color:[UIColor whiteColor]];
        startTime += 0.5f;
    }
}
//设置x上面的字距离
- (void)setX_labels:(NSArray *)_x_labels
{
    x_labels = [NSArray arrayWithArray:_x_labels];
    CGFloat num = ((CGFloat)x_labels.count);
    CGFloat x_interval = 0.85*w/num;
    widthspec=x_interval;
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.1*w, 0.9*h, w*0.85, 0.1*h)];
    v.backgroundColor=[UIColor greenColor];
    v.alpha = 0;
    
    for (int i=0; i<x_labels.count; i++)
    {
        NSString *str = x_labels[i];
        UILabel *label = [[UILabel alloc]
                          initWithFrame:CGRectMake(x_interval*i,
                                                   0, x_interval, 0.1*h)];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        label.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor=[UIColor redColor];
        label.font = [UIFont systemFontOfSize:w/28.0];
        label.text = str;
        [v addSubview:label];
    }
    
    [self addSubview:v];
    [UIView animateWithDuration:1.5f
                     animations:^{
                         v.alpha = 1;
                     }];
}

- (void)setY_labels:(NSArray *)_y_labels
{
    y_labels = [NSArray arrayWithArray:_y_labels];
    CGFloat num = ((CGFloat)y_labels.count);
    CGFloat y_interval = 0.9*h/num;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.1*w, h*0.9)];
    v.alpha = 0;
    
    for (int i=0; i<y_labels.count; i++)
    {
        NSString *str = y_labels[i];
        UILabel *label = [[UILabel alloc]
                          initWithFrame:CGRectMake(0,0.9*h-y_interval*(i+1)+y_interval*0.7,
                                                   0.08*w, y_interval*0.3)];
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        label.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
       // label.transform=CGAffineTransformMakeRotation(M_PI/2);
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:w/28.0];
        label.text = str;
        [v addSubview:label];
    }
    [self addSubview:v];
    [UIView animateWithDuration:1.5f
                     animations:^{
                         v.alpha = 1;
                     }];
}

- (void)addAXis
{
    AFDescribeObj *axis = [[AFDescribeObj alloc]
                           initWithType:AFAnimationStrokeEnd inView:self];
    [axis setStartTime:0.0f andDuration:1.0f];
    [axis addLineFrom:CGPointMake(w*0.10, h*0.90)
              toPoint:CGPointMake(w*0.10, h*0.05)
                color:[UIColor blackColor]];//画横
    [axis addLineFrom:CGPointMake(w*0.10, h*0.90)
              toPoint:CGPointMake(w*0.95, h*0.90)
                color:[UIColor blackColor]];//画竖
    //旁边的箭头
    AFDescribeObj *anchor = [[AFDescribeObj alloc]
                             initWithType:AFAnimationStrokeEnd inView:self];
    [anchor setStartTime:1.0f andDuration:0.5f];
    [anchor addLineFrom:CGPointMake(w*0.10, h*0.05)
                toPoint:CGPointMake(w*0.125, h*0.075)
                  color:[UIColor blackColor]];
    [anchor addLineFrom:CGPointMake(w*0.10, h*0.05)
                toPoint:CGPointMake(w*0.075, h*0.075)
                  color:[UIColor blackColor]];
    [anchor addLineFrom:CGPointMake(w*0.95,h*0.90)
                toPoint:CGPointMake(w*0.925, h*0.925)
                  color:[UIColor blackColor]];
    [anchor addLineFrom:CGPointMake(w*0.95,h*0.90)
                toPoint:CGPointMake(w*0.925, h*0.875)
                  color:[UIColor blackColor]];
}

@end
