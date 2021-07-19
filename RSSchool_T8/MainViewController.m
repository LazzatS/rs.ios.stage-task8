//
//  CanvasViewController.m
//  RSSchool_T8
//
//  Created by Lazzat Seiilova on 17.07.2021.
//

#import "MainViewController.h"
#import "RSSchool_T8-Swift.h"
#import "PaletteViewController.h"

@interface MainViewController () <DrawingSelectionDelegate, TimeSelectionDelegate>
@property (nonatomic, strong) DrawingsViewController *drawingsVC;
@property (nonatomic, strong) TimerViewController *timerVC;
@property (nonatomic, strong) PaletteViewController *palleteVC;
@property (nonatomic, strong) NSString *drawingChosen;
@property (nonatomic) double animationDuration;
@end

@implementation MainViewController

BOOL idle = false;
BOOL draw = false;
BOOL done = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.reloadInputViews;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_drawingChosen == NULL) {
        _drawingChosen = @"Head";
    } else {
        NSLog(@"SO the drawing to draw is %@", _drawingChosen);
    }
    
    NSLog(@"_drawingChosen is %@", _drawingChosen);
    
    idle = true;
    
    //self.view.backgroundColor = [UIColor greenColor];
    UIFont *regularFont = [self useCustomFont:YES :NO];
    UIFont *mediumFont = [self useCustomFont:NO :YES];
    
    // navigation bar
    [self createNavigationBarItems:regularFont];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // canvas
    UIView *canvas = [self createCanvas];

    // buttons
    UIButton *openPaletteButton = [self createCustomButton:@"Open Palette" withFont:mediumFont atX:20 Y:454 withWidth:163 withHeight:32];
    [openPaletteButton addTarget:self action:@selector(openPalletTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *openTimerButton = [self createCustomButton:@"Open Timer" withFont:mediumFont atX:20 Y:506 withWidth:151 withHeight:32];
    [openTimerButton addTarget:self action:@selector(timerTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *drawButton = [self createCustomButton:@"Draw" withFont:mediumFont atX:243 Y:454 withWidth:91 withHeight:32];
    [drawButton addTarget:self action:@selector(drawTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [self createCustomButton:@"Share" withFont:mediumFont atX:239 Y:506 withWidth:95 withHeight:32];
    [shareButton addTarget:self action:@selector(shareTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

- (IBAction)chooseDrawings:(id)sender {
    NSLog(@"chooseDrawingsTapped");
    _drawingsVC = [[DrawingsViewController alloc] init];
    _drawingsVC.delegate = self;
    [self.navigationController pushViewController:self.drawingsVC animated:YES];
}

- (void)didChooseDrawingWithImageTitle:(NSString * _Nonnull)imageTitle {
    NSLog(@"------------------------------------------ %@ ", imageTitle);
    _drawingChosen = imageTitle;
    NSLog(@"NOW drawing is %@", _drawingChosen);
}

- (void)didChooseTimeWithTime:(double)time {
    NSLog(@"****************************************** %f", time);
    _animationDuration = time;
}

- (UIFont *) useCustomFont:(BOOL)regular :(BOOL)medium {
    UIFont *regularFont = [UIFont fontWithName:@"Montserrat-Regular" size:17];
    UIFont *mediumFont = [UIFont fontWithName:@"Montserrat-Medium" size:18];
    if (regular) {
        return regularFont;
    }
    if (medium) {
        return mediumFont;
    }
    return regularFont;
}

- (void) createNavigationBarItems:(UIFont *)customFont {
    
    // title for main view
    UILabel *navMainTitle = [[UILabel alloc] init];
    navMainTitle.font = customFont;
    navMainTitle.tintColor = [UIColor blackColor];
    self.title = @"Artist";
    
    // title for right button
    UILabel *navRightButtonTitle = [[UILabel alloc] init];
    navRightButtonTitle.font = customFont;
    navRightButtonTitle.textColor = [UIColor colorNamed:@"CustomGreenish"];
    
    // right button
    UIBarButtonItem *navBarRightButton = [[UIBarButtonItem alloc] initWithTitle:@"Drawings"
                                                                    style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(chooseDrawings:)];
    [navBarRightButton setTintColor:[UIColor colorNamed:@"CustomGreenish"]];
    
    self.navigationItem.rightBarButtonItem = navBarRightButton;
}

- (UIView *) createCanvas {
    UIView *canvas = [[UIView alloc] initWithFrame:CGRectMake(38, 104, 300, 300)];
    canvas.backgroundColor = [UIColor whiteColor];
    canvas.layer.cornerRadius = 8;
    canvas.layer.shadowRadius = 8;
    canvas.layer.shadowOpacity = 1;
    canvas.layer.shadowPath = [UIBezierPath bezierPathWithRect:canvas.bounds].CGPath;
    canvas.layer.shadowColor = [[UIColor colorNamed: @"CustomBluish"] CGColor];
    
    [self.view addSubview:canvas];
    return canvas;
}

- (UIButton *) createCustomButton:(NSString *)buttonName withFont:(UIFont *)customFont atX:(CGFloat)x Y:(CGFloat)y withWidth:(CGFloat)width withHeight:(CGFloat)height {
    UIButton *buttonStyle = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [buttonStyle setTitle:buttonName forState:UIControlStateNormal];
    [buttonStyle setTitleColor:[UIColor colorNamed:@"CustomGreenish"] forState:UIControlStateNormal];
    buttonStyle.titleLabel.font = customFont;
    buttonStyle.layer.borderWidth = 1;
    buttonStyle.layer.borderColor = [[UIColor colorNamed:@"BlackOpaque"] CGColor];
    buttonStyle.layer.cornerRadius = 10;
    buttonStyle.layer.shadowRadius = 2;
    buttonStyle.layer.shadowPath = [UIBezierPath bezierPathWithRect:buttonStyle.bounds].CGPath;
    buttonStyle.layer.shadowColor = [[UIColor colorNamed:@"BlackOpaque"] CGColor];
    
    [buttonStyle setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    [self.view addSubview:buttonStyle];
    return buttonStyle;
}

- (IBAction)drawTapped:(id)sender {
    
    UIView *canvas = [self createCanvas];
    NSString *drawingTitle = _drawingChosen;
    double animationTime = _animationDuration;
    UIColor *color1 = [UIColor redColor];
    UIColor *color2 = [UIColor greenColor];
    UIColor *color3 = [UIColor blueColor];

    NSLog(@"SOOOOO ******** %@", drawingTitle);
    
    [self createDrawingOnCanvas:canvas ofDrawing:drawingTitle withColor1:color1 withColor2:color2 withColor3:color3 withAnimationDuration:animationTime];
}

- (IBAction)shareTapped:(id)sender {
    NSLog(@"share tapped");
}

- (IBAction)timerTapped:(id)sender {
    NSLog(@"timer tapped button tapped");
    _timerVC = [[TimerViewController alloc] init];
    _timerVC.delegate = self;
    [self.navigationController pushViewController:self.timerVC animated:YES];
    
}

- (IBAction)openPalletTapped:(id)sender {
    PaletteViewController *paleteVC = [[PaletteViewController alloc] init];
    self.modalTransitionStyle = UIModalPresentationFormSheet;
    [self.navigationController pushViewController:paleteVC animated:YES];
}

- (void) createDrawingOnCanvas:(UIView *)canvas ofDrawing:(NSString *)drawingTitle withColor1:(UIColor *)color1 withColor2:(UIColor *)color2 withColor3:(UIColor *)color3 withAnimationDuration:(double)time {
    drawingTitle = _drawingChosen;
    time = _animationDuration;
    
    if ([drawingTitle isEqual: @"Head"]) {
        [self drawHeadOnCanvas:canvas withDuration:time withColor1:color1 withColor2:color2 withColor3:color3];
    } else if ([drawingTitle isEqual: @"Landscape"]) {
        [self drawLandscapeOnCanvas:canvas withDuration:time withColor1:color1 withColor2:color2 withColor3:color3];
    }
    
}



- (void) drawHeadOnCanvas:(UIView *)canvas withDuration:(double)time withColor1:(UIColor *)firstColor withColor2:(UIColor *)secondColor withColor3:(UIColor *)thirdColor {
    // face
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(61.5, 29)];
    [path1 addLineToPoint:CGPointMake(77, 89)];
    [path1 addLineToPoint:CGPointMake(89, 112)];
    [path1 addLineToPoint:CGPointMake(106.5, 131.5)];
    [path1 addLineToPoint:CGPointMake(133.5, 154)];
    [path1 addLineToPoint:CGPointMake(157, 159.5)];
    [path1 addLineToPoint:CGPointMake(193, 142)];
    [path1 addLineToPoint:CGPointMake(220, 112)];
    [path1 addLineToPoint:CGPointMake(228.5, 100)];
    [path1 addLineToPoint:CGPointMake(229, 77.5)];
    [path1 addLineToPoint:CGPointMake(230.5, 50.5)];
    [path1 addLineToPoint:CGPointMake(218.5, 40.5)];
    [path1 addLineToPoint:CGPointMake(202, 43.5)];
    [path1 addLineToPoint:CGPointMake(191, 60.5)];
    [path1 addLineToPoint:CGPointMake(189, 83.5)];
    [path1 addLineToPoint:CGPointMake(193, 96)];
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.frame = canvas.bounds;
    shapeLayer1.path = [path1 CGPath];
    shapeLayer1.strokeColor = [firstColor CGColor];
    shapeLayer1.lineWidth = 3.0;
    shapeLayer1.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *drawAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation1.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation1.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation1.duration = time;
    drawAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer1 addAnimation:drawAnimation1 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer1];
    
    
    // lips
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(184, 100)];
    [path2 addLineToPoint:CGPointMake(175.5, 98.5)];
    [path2 addLineToPoint:CGPointMake(166, 100.5)];
    [path2 addLineToPoint:CGPointMake(158, 101.5)];
    [path2 addLineToPoint:CGPointMake(148.5, 100.5)];
    [path2 addLineToPoint:CGPointMake(140, 99)];
    [path2 addLineToPoint:CGPointMake(133.5, 98.5)];
    [path2 addLineToPoint:CGPointMake(126, 100)];
    [path2 addLineToPoint:CGPointMake(121.5, 102)];
    [path2 addLineToPoint:CGPointMake(127.5, 104.5)];
    [path2 addLineToPoint:CGPointMake(132, 108)];
    [path2 addLineToPoint:CGPointMake(136.5, 113)];
    [path2 addLineToPoint:CGPointMake(142.5, 115.5)];
    [path2 addLineToPoint:CGPointMake(150, 116.5)];
    [path2 addLineToPoint:CGPointMake(157, 115.5)];
    [path2 addLineToPoint:CGPointMake(164.5, 116.5)];
    [path2 addLineToPoint:CGPointMake(170.5, 115.5)];
    [path2 addLineToPoint:CGPointMake(177, 111.5)];
    [path2 addLineToPoint:CGPointMake(184, 103.5)];
    [path2 addLineToPoint:CGPointMake(188.5, 97.5)];
    [path2 addLineToPoint:CGPointMake(180.5, 96.5)];
    [path2 addLineToPoint:CGPointMake(171.5, 95.5)];
    [path2 addLineToPoint:CGPointMake(162.5, 93.5)];
    [path2 addLineToPoint:CGPointMake(154, 93)];
    [path2 addLineToPoint:CGPointMake(144, 94.5)];
    [path2 addLineToPoint:CGPointMake(135, 96.5)];
    [path2 addLineToPoint:CGPointMake(125, 97.5)];
    [path2 addLineToPoint:CGPointMake(118, 97)];
    [path2 addLineToPoint:CGPointMake(127.5, 91)];
    [path2 addLineToPoint:CGPointMake(136.5, 84.5)];
    [path2 addLineToPoint:CGPointMake(142.5, 81)];
    [path2 addLineToPoint:CGPointMake(147.5, 82.5)];
    [path2 addLineToPoint:CGPointMake(153, 84.5)];
    [path2 addLineToPoint:CGPointMake(159.5, 83.5)];
    [path2 addLineToPoint:CGPointMake(166, 82.5)];
    [path2 addLineToPoint:CGPointMake(171.5, 83.5)];
    [path2 addLineToPoint:CGPointMake(174.5, 84.5)];
    [path2 addLineToPoint:CGPointMake(179.5, 89.5)];
    [path2 addLineToPoint:CGPointMake(187, 94)];
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.frame = canvas.bounds;
    shapeLayer2.path = [path2 CGPath];
    shapeLayer2.strokeColor = [secondColor CGColor];
    shapeLayer2.lineWidth = 3.0;
    shapeLayer2.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *drawAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation2.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation2.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation2.duration = time;
    drawAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer2 addAnimation:drawAnimation2 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer2];

    
    //neck
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint:CGPointMake(189.5, 102.5)];
    [path3 addLineToPoint:CGPointMake(194, 108.5)];
    [path3 addLineToPoint:CGPointMake(196.5, 115)];
    [path3 addLineToPoint:CGPointMake(193, 124)];
    [path3 addLineToPoint:CGPointMake(186, 132.5)];
    [path3 addLineToPoint:CGPointMake(177, 139.5)];
    [path3 addLineToPoint:CGPointMake(167.5, 132.5)];
    [path3 addLineToPoint:CGPointMake(157, 128.5)];
    [path3 addLineToPoint:CGPointMake(147.5, 129)];
    [path3 addLineToPoint:CGPointMake(135.5, 132.5)];
    [path3 addLineToPoint:CGPointMake(127.5, 142)];
    [path3 addLineToPoint:CGPointMake(121, 154.5)];
    [path3 addLineToPoint:CGPointMake(109.5, 147.5)];
    [path3 addLineToPoint:CGPointMake(101.5, 137.5)];
    [path3 addLineToPoint:CGPointMake(93, 128.5)];
    [path3 addLineToPoint:CGPointMake(90, 142)];
    [path3 addLineToPoint:CGPointMake(89, 170.5)];
    [path3 addLineToPoint:CGPointMake(87, 187.5)];
    [path3 addLineToPoint:CGPointMake(86, 199)];
    [path3 addLineToPoint:CGPointMake(74.5, 207.5)];
    [path3 addLineToPoint:CGPointMake(63.5, 214.5)];
    [path3 addLineToPoint:CGPointMake(81, 221)];
    [path3 addLineToPoint:CGPointMake(94.5, 229.5)];
    [path3 addLineToPoint:CGPointMake(105, 243.5)];
    [path3 addLineToPoint:CGPointMake(119, 261)];
    [path3 addLineToPoint:CGPointMake(138, 279)];
    [path3 addLineToPoint:CGPointMake(157, 285.5)];
    [path3 addLineToPoint:CGPointMake(171, 283)];
    [path3 addLineToPoint:CGPointMake(186, 277.5)];
    [path3 addLineToPoint:CGPointMake(199.5, 261)];
    [path3 addLineToPoint:CGPointMake(209.5, 239.5)];
    [path3 addLineToPoint:CGPointMake(219, 223.5)];
    [path3 addLineToPoint:CGPointMake(233.5, 217)];
    [path3 addLineToPoint:CGPointMake(237, 208)];
    [path3 addLineToPoint:CGPointMake(230.5, 201.5)];
    [path3 addLineToPoint:CGPointMake(221, 173)];
    [path3 addLineToPoint:CGPointMake(219, 150)];
    [path3 addLineToPoint:CGPointMake(215, 126.5)];
    [path3 addLineToPoint:CGPointMake(212, 137.5)];
    [path3 addLineToPoint:CGPointMake(204, 145.5)];
    [path3 addLineToPoint:CGPointMake(196.5, 154.5)];
    [path3 addLineToPoint:CGPointMake(180, 170.5)];
    [path3 addLineToPoint:CGPointMake(170, 185)];
    [path3 addLineToPoint:CGPointMake(161.5, 206.5)];
    [path3 addLineToPoint:CGPointMake(158.5, 232.5)];
    [path3 addLineToPoint:CGPointMake(158.5, 261)];
    [path3 addLineToPoint:CGPointMake(158.5, 279)];
    
    CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.frame = canvas.bounds;
    shapeLayer3.path = [path3 CGPath];
    shapeLayer3.strokeColor = [thirdColor CGColor];
    shapeLayer3.lineWidth = 3.0;
    shapeLayer3.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *drawAnimation3 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation3.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation3.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation3.duration = time;
    drawAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer3 addAnimation:drawAnimation3 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer3];
    
}


- (void) drawLandscapeOnCanvas:(UIView *)canvas withDuration:(double)time withColor1:(UIColor *)firstColor withColor2:(UIColor *)secondColor withColor3:(UIColor *)thirdColor {
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint: CGPointMake(249, 134)];
    [path1 addLineToPoint: CGPointMake(255.5, 143.5)];
    [path1 addLineToPoint: CGPointMake(268, 156)];
    [path1 addLineToPoint: CGPointMake(267, 139.5)];
    [path1 addLineToPoint: CGPointMake(264.5, 124)];
    [path1 addLineToPoint: CGPointMake(259.5, 110.5)];
    [path1 addLineToPoint: CGPointMake(255.5, 102)];
    [path1 addLineToPoint: CGPointMake(251.5, 94.5)];
    [path1 addLineToPoint: CGPointMake(245.5, 86)];
    [path1 addLineToPoint: CGPointMake(240.5, 85.5)];
    [path1 addLineToPoint: CGPointMake(238, 86)];
    [path1 addLineToPoint: CGPointMake(234, 86)];
    [path1 addLineToPoint: CGPointMake(230, 87.5)];
    [path1 addLineToPoint: CGPointMake(226.5, 85.5)];
    [path1 addLineToPoint: CGPointMake(223.5, 84.5)];
    [path1 addLineToPoint: CGPointMake(219.5, 85.5)];
    [path1 addLineToPoint: CGPointMake(214.5, 86.5)];
    [path1 addLineToPoint: CGPointMake(210, 87.5)];
    [path1 addLineToPoint: CGPointMake(207, 86)];
    [path1 addLineToPoint: CGPointMake(203, 84.5)];
    [path1 addLineToPoint: CGPointMake(199, 84.8)];
    [path1 addLineToPoint: CGPointMake(192, 85.3)];
    [path1 addLineToPoint: CGPointMake(185.5, 85.7)];
    [path1 addLineToPoint: CGPointMake(182.5, 86)];
    [path1 addLineToPoint: CGPointMake(176, 84.5)];
    [path1 addLineToPoint: CGPointMake(170, 84)];
    [path1 addLineToPoint: CGPointMake(166, 83.5)];
    [path1 addLineToPoint: CGPointMake(160.5, 85.5)];
    [path1 addLineToPoint: CGPointMake(157, 83.5)];
    [path1 addLineToPoint: CGPointMake(150, 83)];
    [path1 addLineToPoint: CGPointMake(155.5, 82)];
    [path1 addLineToPoint: CGPointMake(159, 79)];
    [path1 addLineToPoint: CGPointMake(160.5, 77)];
    [path1 addLineToPoint: CGPointMake(163.5, 74.5)];
    [path1 addLineToPoint: CGPointMake(166, 71)];
    [path1 addLineToPoint: CGPointMake(170, 70)];
    [path1 addLineToPoint: CGPointMake(177.5, 70)];
    [path1 addLineToPoint: CGPointMake(183, 69)];
    [path1 addLineToPoint: CGPointMake(188, 68)];
    [path1 addLineToPoint: CGPointMake(190, 64)];
    [path1 addLineToPoint: CGPointMake(196.5, 63)];
    [path1 addLineToPoint: CGPointMake(200, 65.5)];
    [path1 addLineToPoint: CGPointMake(204, 64)];
    [path1 addLineToPoint: CGPointMake(208, 65.5)];
    [path1 addLineToPoint: CGPointMake(210, 61.5)];
    [path1 addLineToPoint: CGPointMake(214.5, 59.5)];
    [path1 addLineToPoint: CGPointMake(220.5, 55)];
    [path1 addLineToPoint: CGPointMake(210, 52)];
    [path1 addLineToPoint: CGPointMake(196.5, 44.5)];
    [path1 addLineToPoint: CGPointMake(179, 37.5)];
    [path1 addLineToPoint: CGPointMake(159, 33.5)];
    [path1 addLineToPoint: CGPointMake(143.5, 32.5)];
    [path1 addLineToPoint: CGPointMake(126.5, 33.5)];
    [path1 addLineToPoint: CGPointMake(110, 36)];
    [path1 addLineToPoint: CGPointMake(97, 41)];
    [path1 addLineToPoint: CGPointMake(85.5, 46)];
    [path1 addLineToPoint: CGPointMake(91, 49)];
    [path1 addLineToPoint: CGPointMake(95, 53)];
    [path1 addLineToPoint: CGPointMake(98, 58.5)];
    [path1 addLineToPoint: CGPointMake(98.5, 64)];
    [path1 addLineToPoint: CGPointMake(95, 72)];
    [path1 addLineToPoint: CGPointMake(89.5, 77)];
    [path1 addLineToPoint: CGPointMake(85.5, 79)];
    [path1 addLineToPoint: CGPointMake(81, 77)];
    [path1 addLineToPoint: CGPointMake(74, 76)];
    [path1 addLineToPoint: CGPointMake(69, 72)];
    [path1 addLineToPoint: CGPointMake(65.5, 65.5)];
    [path1 addLineToPoint: CGPointMake(60, 59.5)];
    [path1 addLineToPoint: CGPointMake(53, 70.5)];
    [path1 addLineToPoint: CGPointMake(44.5, 80.5)];
    [path1 addLineToPoint: CGPointMake(37, 92)];
    [path1 addLineToPoint: CGPointMake(31.5, 103)];
    [path1 addLineToPoint: CGPointMake(30, 109)];
    [path1 addLineToPoint: CGPointMake(33.5, 109)];
    [path1 addLineToPoint: CGPointMake(37, 108)];
    [path1 addLineToPoint: CGPointMake(43.5, 112)];
    [path1 addLineToPoint: CGPointMake(49.5, 115)];
    [path1 addLineToPoint: CGPointMake(55.5, 117)];
    [path1 addLineToPoint: CGPointMake(59, 116)];
    [path1 addLineToPoint: CGPointMake(64, 118.5)];
    [path1 addLineToPoint: CGPointMake(61.5, 119.5)];
    [path1 addLineToPoint: CGPointMake(55.5, 121)];
    [path1 addLineToPoint: CGPointMake(50.5, 120)];
    [path1 addLineToPoint: CGPointMake(48.5, 121)];
    [path1 addLineToPoint: CGPointMake(44.5, 121.5)];
    [path1 addLineToPoint: CGPointMake(41.5, 122)];
    [path1 addLineToPoint: CGPointMake(39.5, 123)];
    [path1 addLineToPoint: CGPointMake(37.5, 122)];
    [path1 addLineToPoint: CGPointMake(35.5, 121)];
    [path1 addLineToPoint: CGPointMake(30, 119.5)];
    [path1 addLineToPoint: CGPointMake(24.5, 122)];
    [path1 addLineToPoint: CGPointMake(22, 130.5)];
    [path1 addLineToPoint: CGPointMake(20, 156.5)];
    [path1 addLineToPoint: CGPointMake(24.5, 186.5)];
    [path1 addLineToPoint: CGPointMake(31.5, 179.5)];
    [path1 addLineToPoint: CGPointMake(37, 175.5)];
    [path1 addLineToPoint: CGPointMake(48.5, 163)];
    [path1 addLineToPoint: CGPointMake(59, 151.5)];
    [path1 moveToPoint: CGPointMake(249, 134)];
    [path1 addLineToPoint: CGPointMake(238, 139.5)];
    [path1 moveToPoint: CGPointMake(249, 134)];
    [path1 addLineToPoint: CGPointMake(247.17, 143.5)];
    [path1 addLineToPoint: CGPointMake(242, 155)];
    [path1 moveToPoint: CGPointMake(238, 139.5)];
    [path1 addLineToPoint: CGPointMake(226.5, 116)];
    [path1 addLineToPoint: CGPointMake(218, 108.5)];
    [path1 addLineToPoint: CGPointMake(210, 118.5)];
    [path1 addLineToPoint: CGPointMake(199, 131)];
    [path1 addLineToPoint: CGPointMake(194.5, 128.5)];
    [path1 addLineToPoint: CGPointMake(177.5, 146.5)];
    [path1 addLineToPoint: CGPointMake(163.5, 167)];
    [path1 moveToPoint: CGPointMake(238, 139.5)];
    [path1 addLineToPoint: CGPointMake(242, 146.5)];
    [path1 addLineToPoint: CGPointMake(247.17, 155)];
    [path1 moveToPoint: CGPointMake(163.5, 167)];
    [path1 addLineToPoint: CGPointMake(155.5, 158)];
    [path1 addLineToPoint: CGPointMake(135, 138)];
    [path1 addLineToPoint: CGPointMake(127.5, 118.5)];
    [path1 addLineToPoint: CGPointMake(123, 117)];
    [path1 addLineToPoint: CGPointMake(116.5, 108.5)];
    [path1 moveToPoint: CGPointMake(163.5, 167)];
    [path1 addLineToPoint: CGPointMake(165, 169.5)];
    [path1 addLineToPoint: CGPointMake(167, 173)];
    [path1 addLineToPoint: CGPointMake(174.25, 180.25)];
    [path1 moveToPoint: CGPointMake(116.5, 108.5)];
    [path1 addLineToPoint: CGPointMake(105, 117)];
    [path1 addLineToPoint: CGPointMake(101.5, 124)];
    [path1 addLineToPoint: CGPointMake(90.5, 136.5)];
    [path1 addLineToPoint: CGPointMake(84.5, 134)];
    [path1 moveToPoint: CGPointMake(116.5, 108.5)];
    [path1 addLineToPoint: CGPointMake(112.5, 116)];
    [path1 addLineToPoint: CGPointMake(111, 124)];
    [path1 moveToPoint: CGPointMake(84.5, 134)];
    [path1 addLineToPoint: CGPointMake(69, 154)];
    [path1 addLineToPoint: CGPointMake(59, 151.5)];
    [path1 moveToPoint: CGPointMake(84.5, 134)];
    [path1 addLineToPoint: CGPointMake(85.5, 146.5)];
    [path1 addLineToPoint: CGPointMake(86.5, 158)];
    [path1 moveToPoint: CGPointMake(59, 151.5)];
    [path1 addLineToPoint: CGPointMake(62.5, 157.5)];
    [path1 addLineToPoint: CGPointMake(64, 164.5)];
    [path1 addLineToPoint: CGPointMake(67, 174)];
    [path1 addLineToPoint: CGPointMake(69, 183.5)];
    [path1 moveToPoint: CGPointMake(181.5, 187.5)];
    [path1 addLineToPoint: CGPointMake(174.25, 180.25)];
    [path1 moveToPoint: CGPointMake(258.5, 175)];
    [path1 addLineToPoint: CGPointMake(249, 158)];
    [path1 addLineToPoint: CGPointMake(247.17, 155)];
    [path1 moveToPoint: CGPointMake(174.25, 180.25)];
    [path1 addLineToPoint: CGPointMake(188, 175.5)];
    [path1 addLineToPoint: CGPointMake(189.16, 177)];
    [path1 moveToPoint: CGPointMake(196.5, 186.5)];
    [path1 addLineToPoint: CGPointMake(189.16, 177)];
    [path1 moveToPoint: CGPointMake(189.16, 177)];
    [path1 addLineToPoint: CGPointMake(196.5, 174)];
    [path1 addLineToPoint: CGPointMake(203, 177)];
    [path1 addLineToPoint: CGPointMake(213, 183.5)];
    [path1 addLineToPoint: CGPointMake(223.5, 187.5)];
    [path1 addLineToPoint: CGPointMake(232, 194.5)];
    [path1 addLineToPoint: CGPointMake(238, 196)];
    [path1 addLineToPoint: CGPointMake(253.5, 208)];
    [path1 moveToPoint: CGPointMake(108, 149)];
    [path1 addLineToPoint: CGPointMake(108.8, 140.5)];
    [path1 addLineToPoint: CGPointMake(109.5, 131)];

    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.frame = canvas.bounds;
    shapeLayer1.path = [path1 CGPath];
    shapeLayer1.strokeColor = [firstColor CGColor];
    shapeLayer1.lineWidth = time;
    shapeLayer1.fillColor = [[UIColor clearColor] CGColor];

    CABasicAnimation *drawAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation1.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation1.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation1.duration = time;
    drawAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer1 addAnimation:drawAnimation1 forKey:@"drawRectStroke"];
    
     [canvas.layer addSublayer:shapeLayer1];
    
    
    // land
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint: CGPointMake(35.5, 213.5)];
    [path2 addLineToPoint: CGPointMake(50, 211)];
    [path2 addLineToPoint: CGPointMake(64, 210)];
    [path2 addLineToPoint: CGPointMake(81.5, 200.5)];
    [path2 addLineToPoint: CGPointMake(98.5, 195.5)];
    [path2 addLineToPoint: CGPointMake(114.5, 202)];
    [path2 addLineToPoint: CGPointMake(127.25, 207.75)];
    [path2 moveToPoint: CGPointMake(140, 213.5)];
    [path2 addLineToPoint: CGPointMake(127.25, 207.75)];
    [path2 moveToPoint: CGPointMake(127.25, 207.75)];
    [path2 addLineToPoint: CGPointMake(140, 204)];
    [path2 addLineToPoint: CGPointMake(150, 205.5)];
    [path2 addLineToPoint: CGPointMake(159.5, 207.75)];
    [path2 addLineToPoint: CGPointMake(173, 210)];
    [path2 addLineToPoint: CGPointMake(195, 217.5)];
    [path2 moveToPoint: CGPointMake(185.5, 220)];
    [path2 addLineToPoint: CGPointMake(198, 217.5)];
    [path2 addLineToPoint: CGPointMake(208.5, 212)];
    [path2 addLineToPoint: CGPointMake(222.5, 210)];
    [path2 addLineToPoint: CGPointMake(237, 209)];
    [path2 addLineToPoint: CGPointMake(257, 207.75)];
    [path2 moveToPoint: CGPointMake(56.5, 241.5)];
    [path2 addLineToPoint: CGPointMake(70.5, 240)];
    [path2 addLineToPoint: CGPointMake(87.5, 238)];
    [path2 addLineToPoint: CGPointMake(104.5, 241.5)];
    [path2 addLineToPoint: CGPointMake(129, 244.5)];
    [path2 addLineToPoint: CGPointMake(173, 249)];
    [path2 moveToPoint: CGPointMake(140, 258.5)];
    [path2 addLineToPoint: CGPointMake(163.5, 252.5)];
    [path2 addLineToPoint: CGPointMake(185.5, 241.5)];
    [path2 addLineToPoint: CGPointMake(198, 235)];
    [path2 addLineToPoint: CGPointMake(216.5, 245)];
    [path2 addLineToPoint: CGPointMake(238.5, 255)];
    [path2 moveToPoint: CGPointMake(86, 265)];
    [path2 addLineToPoint: CGPointMake(98.5, 262.5)];
    [path2 addLineToPoint: CGPointMake(123, 265)];
    [path2 addLineToPoint: CGPointMake(151, 266)];
    [path2 addLineToPoint: CGPointMake(173, 263)];
    [path2 addLineToPoint: CGPointMake(195, 258.5)];
    [path2 addLineToPoint: CGPointMake(218, 256)];

    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.frame = canvas.bounds;
    shapeLayer2.path = [path2 CGPath];
    shapeLayer2.strokeColor = [secondColor CGColor];
    shapeLayer2.lineWidth = 3.0;
    shapeLayer2.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *drawAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation2.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation2.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation2.duration = time;
    drawAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer2 addAnimation:drawAnimation2 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer2];
    
    // mountains
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint: CGPointMake(103.5, 153)];
    [path3 addLineToPoint: CGPointMake(105.5, 159.5)];
    [path3 addLineToPoint: CGPointMake(106.5, 170.5)];
    [path3 addLineToPoint: CGPointMake(104, 189)];
    [path3 addLineToPoint: CGPointMake(100.5, 206.5)];
    [path3 addLineToPoint: CGPointMake(101, 216)];
    [path3 addLineToPoint: CGPointMake(104, 224)];
    [path3 moveToPoint: CGPointMake(108.5, 224)];
    [path3 addLineToPoint: CGPointMake(109.5, 212.5)];
    [path3 moveToPoint: CGPointMake(110.5, 208.5)];
    [path3 addLineToPoint: CGPointMake(109.5, 196.5)];
    [path3 addLineToPoint: CGPointMake(108.5, 188.5)];
    [path3 addLineToPoint: CGPointMake(107.5, 181)];
    [path3 moveToPoint: CGPointMake(116, 175.5)];
    [path3 addLineToPoint: CGPointMake(118, 183.5)];
    [path3 addLineToPoint: CGPointMake(119.5, 194)];
    [path3 moveToPoint: CGPointMake(121, 184.5)];
    [path3 addLineToPoint: CGPointMake(121.5, 190.5)];
    [path3 addLineToPoint: CGPointMake(124, 199.5)];
    [path3 addLineToPoint: CGPointMake(126.5, 205.5)];
    [path3 moveToPoint: CGPointMake(125, 194)];
    [path3 addLineToPoint: CGPointMake(125.5, 198.5)];
    [path3 addLineToPoint: CGPointMake(129, 204.5)];
    [path3 moveToPoint: CGPointMake(138, 182)];
    [path3 addLineToPoint: CGPointMake(139, 189)];
    [path3 addLineToPoint: CGPointMake(140.5, 196)];
    [path3 addLineToPoint: CGPointMake(143, 201.5)];
    [path3 moveToPoint: CGPointMake(146.5, 203)];
    [path3 addLineToPoint: CGPointMake(143.5, 197)];
    [path3 addLineToPoint: CGPointMake(142, 192)];
    [path3 addLineToPoint: CGPointMake(141.5, 187)];
    [path3 moveToPoint: CGPointMake(139, 196)];
    [path3 addLineToPoint: CGPointMake(137, 190)];
    [path3 addLineToPoint: CGPointMake(136, 184)];
    [path3 addLineToPoint: CGPointMake(135.5, 176)];
    [path3 addLineToPoint: CGPointMake(136, 169)];
    [path3 moveToPoint: CGPointMake(79, 158.5)];
    [path3 addLineToPoint: CGPointMake(76.5, 166)];
    [path3 addLineToPoint: CGPointMake(75.5, 173)];
    [path3 addLineToPoint: CGPointMake(75.5, 181)];
    [path3 moveToPoint: CGPointMake(73.5, 175.5)];
    [path3 addLineToPoint: CGPointMake(74, 167.5)];
    [path3 addLineToPoint: CGPointMake(76.5, 158.5)];
    [path3 addLineToPoint: CGPointMake(80, 151)];
    [path3 moveToPoint: CGPointMake(82.5, 140)];
    [path3 addLineToPoint: CGPointMake(78.5, 146)];
    [path3 addLineToPoint: CGPointMake(75.5, 152)];
    [path3 moveToPoint: CGPointMake(38.5, 181)];
    [path3 addLineToPoint: CGPointMake(36.5, 189)];
    [path3 addLineToPoint: CGPointMake(33.5, 196.5)];
    [path3 addLineToPoint: CGPointMake(30.5, 202)];
    [path3 moveToPoint: CGPointMake(41.5, 181)];
    [path3 addLineToPoint: CGPointMake(39.5, 188.5)];
    [path3 addLineToPoint: CGPointMake(36, 197.5)];
    [path3 moveToPoint: CGPointMake(43, 173)];
    [path3 addLineToPoint: CGPointMake(42, 178.5)];
    [path3 moveToPoint: CGPointMake(56.5, 159.5)];
    [path3 addLineToPoint: CGPointMake(54, 169)];
    [path3 moveToPoint: CGPointMake(55.5, 172)];
    [path3 addLineToPoint: CGPointMake(54, 178.5)];
    [path3 addLineToPoint: CGPointMake(53.5, 186)];
    [path3 moveToPoint: CGPointMake(52.5, 174.5)];
    [path3 addLineToPoint: CGPointMake(51.5, 184)];
    [path3 moveToPoint: CGPointMake(62.5, 187)];
    [path3 addLineToPoint: CGPointMake(63, 193)];
    [path3 moveToPoint: CGPointMake(64.5, 194)];
    [path3 addLineToPoint: CGPointMake(70.5, 208.5)];
    [path3 moveToPoint: CGPointMake(80, 174.5)];
    [path3 addLineToPoint: CGPointMake(80.5, 185.5)];
    [path3 addLineToPoint: CGPointMake(81.5, 194)];
    [path3 moveToPoint: CGPointMake(191.5, 141)];
    [path3 addLineToPoint: CGPointMake(192, 145.5)];
    [path3 addLineToPoint: CGPointMake(194.5, 152)];
    [path3 addLineToPoint: CGPointMake(195.04, 154.5)];
    [path3 moveToPoint: CGPointMake(194.5, 166.5)];
    [path3 addLineToPoint: CGPointMake(196, 159)];
    [path3 addLineToPoint: CGPointMake(195.04, 154.5)];
    [path3 moveToPoint: CGPointMake(196, 140.5)];
    [path3 addLineToPoint: CGPointMake(195.5, 146.5)];
    [path3 addLineToPoint: CGPointMake(195.04, 154.5)];
    [path3 moveToPoint: CGPointMake(207.5, 133.5)];
    [path3 addLineToPoint: CGPointMake(205.5, 141)];
    [path3 addLineToPoint: CGPointMake(203.5, 148.5)];
    [path3 moveToPoint: CGPointMake(226, 144)];
    [path3 addLineToPoint: CGPointMake(227.5, 153.5)];
    [path3 addLineToPoint: CGPointMake(233.5, 166.5)];
    [path3 moveToPoint: CGPointMake(205.5, 188.5)];
    [path3 addLineToPoint: CGPointMake(210, 196)];
    [path3 addLineToPoint: CGPointMake(215, 201.5)];
    [path3 moveToPoint: CGPointMake(203.5, 202)];
    [path3 addLineToPoint: CGPointMake(198, 198.5)];
    [path3 moveToPoint: CGPointMake(253.5, 151)];
    [path3 addLineToPoint: CGPointMake(255, 154.5)];
    [path3 moveToPoint: CGPointMake(258, 153.5)];
    [path3 addLineToPoint: CGPointMake(259, 158.5)];
    [path3 addLineToPoint: CGPointMake(260.5, 162.5)];
    [path3 moveToPoint: CGPointMake(119.5, 136)];
    [path3 addLineToPoint: CGPointMake(121.5, 145.5)];
    [path3 addLineToPoint: CGPointMake(126.5, 148.5)];
    [path3 addLineToPoint: CGPointMake(129, 154.5)];
    [path3 moveToPoint: CGPointMake(219, 116.5)];
    [path3 addLineToPoint: CGPointMake(221, 120)];
    [path3 addLineToPoint: CGPointMake(217, 124)];
    [path3 moveToPoint: CGPointMake(215, 122.5)];
    [path3 addLineToPoint: CGPointMake(213.5, 132.5)];
    [path3 moveToPoint: CGPointMake(223.5, 196)];
    [path3 addLineToPoint: CGPointMake(226, 197.5)];
    [path3 addLineToPoint: CGPointMake(231, 199.5)];
    [path3 addLineToPoint: CGPointMake(239.5, 206.5)];
    [path3 moveToPoint: CGPointMake(159.5, 174.5)];
    [path3 addLineToPoint: CGPointMake(162, 181)];
    [path3 addLineToPoint: CGPointMake(168.5, 188.5)];

    CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.frame = canvas.bounds;
    shapeLayer3.path = [path3 CGPath];
    shapeLayer3.strokeColor = [thirdColor CGColor];
    shapeLayer3.lineWidth = 3.0;
    shapeLayer3.fillColor = [[UIColor clearColor] CGColor];

    CABasicAnimation *drawAnimation3 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation3.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation3.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation3.duration = time;
    drawAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer3 addAnimation:drawAnimation3 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer3];

}

@end

/*
 
 CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
 shapeLayer1.frame = canvas.bounds;
 shapeLayer1.path = [path1 CGPath];
 shapeLayer1.strokeColor = [firstColor CGColor];
 shapeLayer1.lineWidth = 3.0;
 shapeLayer1.fillColor = [[UIColor clearColor] CGColor];
 
 CABasicAnimation *drawAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
 drawAnimation1.fromValue = (id)[NSNumber numberWithFloat:0.10];
 drawAnimation1.toValue = (id)[NSNumber numberWithFloat:1.f];
 drawAnimation1.duration = time;
 drawAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
 [shapeLayer1 addAnimation:drawAnimation1 forKey:@"drawRectStroke"];

 [canvas.layer addSublayer:shapeLayer1];
 
 
 
 
 CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
 shapeLayer2.frame = canvas.bounds;
 shapeLayer2.path = [path2 CGPath];
 shapeLayer2.strokeColor = [secondColor CGColor];
 shapeLayer2.lineWidth = 3.0;
 shapeLayer2.fillColor = [[UIColor clearColor] CGColor];
 
 CABasicAnimation *drawAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
 drawAnimation2.fromValue = (id)[NSNumber numberWithFloat:0.10];
 drawAnimation2.toValue = (id)[NSNumber numberWithFloat:1.f];
 drawAnimation2.duration = time;
 drawAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
 [shapeLayer2 addAnimation:drawAnimation2 forKey:@"drawRectStroke"];

 [canvas.layer addSublayer:shapeLayer2];
 
 
 CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
 shapeLayer3.frame = canvas.bounds;
 shapeLayer3.path = [path3 CGPath];
 shapeLayer3.strokeColor = [thirdColor CGColor];
 shapeLayer3.lineWidth = 3.0;
 shapeLayer3.fillColor = [[UIColor clearColor] CGColor];

 CABasicAnimation *drawAnimation3 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
 drawAnimation3.fromValue = (id)[NSNumber numberWithFloat:0.10];
 drawAnimation3.toValue = (id)[NSNumber numberWithFloat:1.f];
 drawAnimation3.duration = time;
 drawAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
 [shapeLayer3 addAnimation:drawAnimation3 forKey:@"drawRectStroke"];

 [canvas.layer addSublayer:shapeLayer3];
 
 
 */
