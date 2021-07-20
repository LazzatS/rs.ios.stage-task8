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
@property (nonatomic, strong) NSString *colorOne;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (_drawingChosen == NULL) {
        _drawingChosen = @"Head";
    }
    
    if (_colorOne == NULL) {
        _colorOne = @"BlackColor";
    }
    
    UIFont *regularFont = [self useCustomFont:YES :NO];
    UIFont *mediumFont = [self useCustomFont:NO :YES];
    
    // navigation bar
    [self createNavigationBarItems:regularFont];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // canvas
    [self createCanvas];

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
    _drawingChosen = imageTitle;
}

- (void)didChooseTimeWithTime:(double)time {
    _animationDuration = time;
}

- (void) didChooseColor:(NSString *)colorName {
    self.colorOne = colorName;
    NSLog(@"color received back is %@", _colorOne);
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
    UIColor *color1 = [UIColor colorNamed:self.colorOne];
    UIColor *color2 = [UIColor colorNamed:self.colorOne];
    UIColor *color3 = [UIColor colorNamed:self.colorOne];
    
    [self createDrawingOnCanvas:canvas ofDrawing:drawingTitle withColor1:color1 withColor2:color2 withColor3:color3 withAnimationDuration:animationTime];
}

- (IBAction)shareTapped:(id)sender {
    NSString *imageName = [[NSString alloc] initWithString: _drawingChosen];
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (IBAction)timerTapped:(id)sender {
    _timerVC = [[TimerViewController alloc] init];
    _timerVC.delegate = self;
    [self.navigationController pushViewController:self.timerVC animated:YES];
    
}

- (IBAction)openPalletTapped:(id)sender {
    _palleteVC = [[PaletteViewController alloc] init];
    [_palleteVC setDelegate:self];
    self.modalTransitionStyle = UIModalPresentationFormSheet;
    [self.navigationController pushViewController:self.palleteVC animated:YES];
}

- (void) createDrawingOnCanvas:(UIView *)canvas ofDrawing:(NSString *)drawingTitle withColor1:(UIColor *)color1 withColor2:(UIColor *)color2 withColor3:(UIColor *)color3 withAnimationDuration:(double)time {
    drawingTitle = _drawingChosen;
    time = _animationDuration;
    
    if ([drawingTitle isEqual: @"Head"]) {
        [self drawHeadOnCanvas:canvas withDuration:time withColor1:color1 withColor2:color2 withColor3:color3];
    } else if ([drawingTitle isEqual: @"Landscape"]) {
        [self drawLandscapeOnCanvas:canvas withDuration:time withColor1:color1 withColor2:color2 withColor3:color3];
    } else if ([drawingTitle isEqual: @"Planet"]) {
        [self drawPlanetOnCanvas:canvas withDuration:time withColor1:color1 withColor2:color2 withColor3:color3];
    } else if ([drawingTitle isEqual:@"Tree"]) {
        [self drawTreeOnCanvas:canvas withDuration:time withColor1:color1 withColor2:color2 withColor3:color3];
    }
    
}

- (UIImage *) drawHeadOnCanvas:(UIView *)canvas withDuration:(double)time withColor1:(UIColor *)firstColor withColor2:(UIColor *)secondColor withColor3:(UIColor *)thirdColor {
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
    shapeLayer1.lineWidth = 1.0;
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
    shapeLayer2.lineWidth = 1.0;
    shapeLayer2.fillColor = [[UIColor colorNamed:@"NeonPink"] CGColor];
    
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
    shapeLayer3.lineWidth = 1.0;
    shapeLayer3.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *drawAnimation3 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation3.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation3.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation3.duration = time;
    drawAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer3 addAnimation:drawAnimation3 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer3];
    
    UIImage *headImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return headImage;
}


- (UIImage *) drawLandscapeOnCanvas:(UIView *)canvas withDuration:(double)time withColor1:(UIColor *)firstColor withColor2:(UIColor *)secondColor withColor3:(UIColor *)thirdColor {
    
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
    shapeLayer1.lineWidth = 1.0;
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
    shapeLayer2.lineWidth = 1.0;
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
    shapeLayer3.lineWidth = 1.0;
    shapeLayer3.fillColor = [[UIColor clearColor] CGColor];

    CABasicAnimation *drawAnimation3 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation3.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation3.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation3.duration = time;
    drawAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer3 addAnimation:drawAnimation3 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer3];
    
    UIImage *landscapeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return landscapeImage;

}

- (UIImage *) drawPlanetOnCanvas:(UIView *)canvas withDuration:(double)time withColor1:(UIColor *)firstColor withColor2:(UIColor *)secondColor withColor3:(UIColor *)thirdColor {
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
     
     [path1 moveToPoint: CGPointMake(60.5, 154)];
     [path1 addLineToPoint: CGPointMake(51.5, 158)];
     [path1 addLineToPoint: CGPointMake(42.5, 165)];
     [path1 addLineToPoint: CGPointMake(34, 173)];
     [path1 addLineToPoint: CGPointMake(28, 181)];
     [path1 addLineToPoint: CGPointMake(26, 189)];
     [path1 addLineToPoint: CGPointMake(27, 197)];
     [path1 addLineToPoint: CGPointMake(31, 203.5)];
     [path1 addLineToPoint: CGPointMake(38, 209)];
     [path1 addLineToPoint: CGPointMake(48.5, 213.5)];
     [path1 addLineToPoint: CGPointMake(59.5, 216)];
     [path1 addLineToPoint: CGPointMake(71, 217)];
     [path1 addLineToPoint: CGPointMake(82, 217.5)];
     [path1 addLineToPoint: CGPointMake(88.5, 217.3)];
     [path1 moveToPoint: CGPointMake(60.5, 154)];
     [path1 addLineToPoint: CGPointMake(61, 147)];
     [path1 addLineToPoint: CGPointMake(63.5, 134.5)];
     [path1 addLineToPoint: CGPointMake(67, 124)];
     [path1 addLineToPoint: CGPointMake(71.5, 112.5)];
     [path1 addLineToPoint: CGPointMake(77, 104)];
     [path1 addLineToPoint: CGPointMake(84, 94.5)];
     [path1 addLineToPoint: CGPointMake(92, 87)];
     [path1 addLineToPoint: CGPointMake(100, 81.5)];
     [path1 addLineToPoint: CGPointMake(108.5, 76.5)];
     [path1 addCurveToPoint: CGPointMake(120, 71.5) controlPoint1: CGPointMake(112.17, 75) controlPoint2: CGPointMake(119.6, 71.9)];
     [path1 addCurveToPoint: CGPointMake(131, 68) controlPoint1: CGPointMake(120.4, 71.1) controlPoint2: CGPointMake(127.5, 69)];
     [path1 addLineToPoint: CGPointMake(147.5, 66.5)];
     [path1 addLineToPoint: CGPointMake(161.5, 67.5)];
     [path1 addLineToPoint: CGPointMake(175.5, 70)];
     [path1 addLineToPoint: CGPointMake(188, 75)];
     [path1 addLineToPoint: CGPointMake(200, 82.5)];
     [path1 addLineToPoint: CGPointMake(208.5, 89.5)];
     [path1 addLineToPoint: CGPointMake(215.5, 96.5)];
     [path1 addLineToPoint: CGPointMake(221.5, 103.5)];
     [path1 moveToPoint: CGPointMake(60.5, 154)];
     [path1 addLineToPoint: CGPointMake(61, 160.5)];
     [path1 addLineToPoint: CGPointMake(61.5, 168)];
     [path1 moveToPoint: CGPointMake(221.5, 103.5)];
     [path1 addLineToPoint: CGPointMake(230.5, 102)];
     [path1 addLineToPoint: CGPointMake(242.5, 101.5)];
     [path1 addLineToPoint: CGPointMake(254, 103)];
     [path1 addLineToPoint: CGPointMake(264.5, 107)];
     [path1 addLineToPoint: CGPointMake(271.5, 112.5)];
     [path1 addLineToPoint: CGPointMake(274, 120)];
     [path1 addLineToPoint: CGPointMake(273.5, 129)];
     [path1 addLineToPoint: CGPointMake(270, 137.5)];
     [path1 addLineToPoint: CGPointMake(259.5, 151)];
     [path1 addLineToPoint: CGPointMake(251, 159.5)];
     [path1 addLineToPoint: CGPointMake(238, 169.5)];
     [path1 addLineToPoint: CGPointMake(234.67, 171.5)];
     [path1 moveToPoint: CGPointMake(221.5, 103.5)];
     [path1 addLineToPoint: CGPointMake(225, 108.5)];
     [path1 addLineToPoint: CGPointMake(228, 115)];
     [path1 moveToPoint: CGPointMake(61.5, 168)];
     [path1 addLineToPoint: CGPointMake(57.5, 170.5)];
     [path1 addLineToPoint: CGPointMake(54, 175)];
     [path1 addLineToPoint: CGPointMake(52.5, 180)];
     [path1 addLineToPoint: CGPointMake(53, 185)];
     [path1 addLineToPoint: CGPointMake(55.5, 189)];
     [path1 addLineToPoint: CGPointMake(60.5, 192)];
     [path1 addLineToPoint: CGPointMake(68, 195)];
     [path1 addLineToPoint: CGPointMake(70.5, 195.47)];
     [path1 moveToPoint: CGPointMake(61.5, 168)];
     [path1 addLineToPoint: CGPointMake(64, 176.5)];
     [path1 addLineToPoint: CGPointMake(66.5, 185)];
     [path1 addLineToPoint: CGPointMake(70.5, 195.47)];
     [path1 moveToPoint: CGPointMake(228, 115)];
     [path1 addLineToPoint: CGPointMake(234.5, 117)];
     [path1 addLineToPoint: CGPointMake(242.5, 118)];
     [path1 addLineToPoint: CGPointMake(245.5, 122)];
     [path1 addLineToPoint: CGPointMake(246, 128)];
     [path1 addLineToPoint: CGPointMake(244.5, 133.5)];
     [path1 addLineToPoint: CGPointMake(240.5, 139)];
     [path1 addLineToPoint: CGPointMake(236.83, 143)];
     [path1 moveToPoint: CGPointMake(228, 115)];
     [path1 addLineToPoint: CGPointMake(231, 122)];
     [path1 addLineToPoint: CGPointMake(234.67, 133.5)];
     [path1 addLineToPoint: CGPointMake(236.83, 143)];
     [path1 moveToPoint: CGPointMake(88.5, 217.3)];
     [path1 addLineToPoint: CGPointMake(98.5, 217)];
     [path1 addLineToPoint: CGPointMake(119.5, 214.5)];
     [path1 addLineToPoint: CGPointMake(137, 211)];
     [path1 addLineToPoint: CGPointMake(152.5, 207)];
     [path1 addLineToPoint: CGPointMake(172, 201)];
     [path1 addLineToPoint: CGPointMake(191.5, 193.5)];
     [path1 addLineToPoint: CGPointMake(207, 186.5)];
     [path1 addLineToPoint: CGPointMake(223, 178.5)];
     [path1 addLineToPoint: CGPointMake(234.67, 171.5)];
     [path1 moveToPoint: CGPointMake(88.5, 217.3)];
     [path1 addLineToPoint: CGPointMake(93.5, 223)];
     [path1 addLineToPoint: CGPointMake(101.5, 229)];
     [path1 addLineToPoint: CGPointMake(110.5, 233.5)];
     [path1 addLineToPoint: CGPointMake(119.5, 237)];
     [path1 addLineToPoint: CGPointMake(130.5, 240.5)];
     [path1 addLineToPoint: CGPointMake(143, 242.5)];
     [path1 addLineToPoint: CGPointMake(155, 242)];
     [path1 addLineToPoint: CGPointMake(166, 241.5)];
     [path1 addLineToPoint: CGPointMake(175.5, 239)];
     [path1 addLineToPoint: CGPointMake(183, 236)];
     [path1 addLineToPoint: CGPointMake(192.5, 231.5)];
     [path1 addLineToPoint: CGPointMake(200, 226.5)];
     [path1 addLineToPoint: CGPointMake(206, 222)];
     [path1 addLineToPoint: CGPointMake(214, 213.5)];
     [path1 addLineToPoint: CGPointMake(222, 203.5)];
     [path1 addLineToPoint: CGPointMake(227.5, 194)];
     [path1 addLineToPoint: CGPointMake(232.5, 182)];
     [path1 addLineToPoint: CGPointMake(234.67, 171.5)];
     [path1 moveToPoint: CGPointMake(236.83, 143)];
     [path1 addLineToPoint: CGPointMake(235, 145)];
     [path1 addLineToPoint: CGPointMake(230, 150)];
     [path1 addLineToPoint: CGPointMake(224, 154.5)];
     [path1 addLineToPoint: CGPointMake(216.5, 159.5)];
     [path1 addLineToPoint: CGPointMake(209.5, 164)];
     [path1 addLineToPoint: CGPointMake(202.5, 168)];
     [path1 addLineToPoint: CGPointMake(195.5, 171.5)];
     [path1 addLineToPoint: CGPointMake(186.5, 176)];
     [path1 addLineToPoint: CGPointMake(175, 181)];
     [path1 addLineToPoint: CGPointMake(163.5, 185)];
     [path1 addLineToPoint: CGPointMake(151.5, 188.5)];
     [path1 addLineToPoint: CGPointMake(140, 191.5)];
     [path1 addLineToPoint: CGPointMake(128, 194)];
     [path1 addLineToPoint: CGPointMake(116, 196)];
     [path1 addLineToPoint: CGPointMake(104, 197)];
     [path1 addLineToPoint: CGPointMake(92.5, 197.5)];
     [path1 addLineToPoint: CGPointMake(83.5, 197)];
     [path1 addLineToPoint: CGPointMake(76, 196.5)];
     [path1 addLineToPoint: CGPointMake(70.5, 195.47)];

    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.frame = canvas.bounds;
    shapeLayer1.path = [path1 CGPath];
    shapeLayer1.strokeColor = [firstColor CGColor];
    shapeLayer1.lineWidth = 1.0;
    shapeLayer1.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *drawAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation1.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation1.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation1.duration = time;
    drawAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer1 addAnimation:drawAnimation1 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer1];
    
    //small circles
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
     
     [path2 moveToPoint: CGPointMake(252.5, 181)];
     [path2 addLineToPoint: CGPointMake(257.5, 177.5)];
     [path2 addLineToPoint: CGPointMake(264.5, 178)];
     [path2 addLineToPoint: CGPointMake(269, 181.5)];
     [path2 addLineToPoint: CGPointMake(270.5, 186.5)];
     [path2 addLineToPoint: CGPointMake(269.5, 191)];
     [path2 addLineToPoint: CGPointMake(266.5, 195.5)];
     [path2 addLineToPoint: CGPointMake(261.5, 197)];
     [path2 addLineToPoint: CGPointMake(255.5, 196)];
     [path2 addLineToPoint: CGPointMake(251.5, 192)];
     [path2 addLineToPoint: CGPointMake(250, 187)];
     [path2 addLineToPoint: CGPointMake(252.5, 181)];
     [path2 closePath];
     
     [path2 moveToPoint: CGPointMake(240, 211)];
     [path2 addLineToPoint: CGPointMake(242, 209)];
     [path2 addLineToPoint: CGPointMake(244.5, 209.8)];
     [path2 addLineToPoint: CGPointMake(246.5, 210.5)];
     [path2 addLineToPoint: CGPointMake(247, 213)];
     [path2 addLineToPoint: CGPointMake(246, 215)];
     [path2 addLineToPoint: CGPointMake(243.5, 216)];
     [path2 addLineToPoint: CGPointMake(241, 215.5)];
     [path2 addLineToPoint: CGPointMake(239.5, 213.5)];
     [path2 addLineToPoint: CGPointMake(240, 211)];
     [path2 closePath];


     [path2 moveToPoint: CGPointMake(74.5, 242)];
     [path2 addLineToPoint: CGPointMake(76.5, 241)];
     [path2 addLineToPoint: CGPointMake(79.5, 242)];
     [path2 addCurveToPoint: CGPointMake(81, 244.5) controlPoint1: CGPointMake(80, 242.67) controlPoint2: CGPointMake(81, 244.1)];
     [path2 addCurveToPoint: CGPointMake(81, 247.5) controlPoint1: CGPointMake(81, 244.9) controlPoint2: CGPointMake(81.17, 246.83)];
     [path2 addLineToPoint: CGPointMake(78.5, 249)];
     [path2 addLineToPoint: CGPointMake(75, 248)];
     [path2 addLineToPoint: CGPointMake(73.5, 247)];
     [path2 addLineToPoint: CGPointMake(73, 244.5)];
     [path2 addLineToPoint: CGPointMake(74.5, 242)];
     [path2 closePath];


     [path2 moveToPoint: CGPointMake(35.5, 76.5)];
     [path2 addCurveToPoint: CGPointMake(41.5, 72) controlPoint1: CGPointMake(37.33, 75) controlPoint2: CGPointMake(41.1, 72)];
     [path2 addLineToPoint: CGPointMake(48, 71)];
     [path2 addLineToPoint: CGPointMake(54.5, 73)];
     [path2 addLineToPoint: CGPointMake(60.5, 80)];
     [path2 addLineToPoint: CGPointMake(61, 89.5)];
     [path2 addLineToPoint: CGPointMake(57, 97)];
     [path2 addLineToPoint: CGPointMake(48.5, 101)];
     [path2 addLineToPoint: CGPointMake(39.5, 99)];
     [path2 addLineToPoint: CGPointMake(33.5, 94.5)];
     [path2 addLineToPoint: CGPointMake(31.5, 85.5)];
     [path2 addLineToPoint: CGPointMake(35.5, 76.5)];
     [path2 closePath];


     [path2 moveToPoint: CGPointMake(217, 51)];
     [path2 addCurveToPoint: CGPointMake(222.5, 50) controlPoint1: CGPointMake(218, 50.67) controlPoint2: CGPointMake(222.1, 50)];
     [path2 addLineToPoint: CGPointMake(227, 53)];
     [path2 addLineToPoint: CGPointMake(227.5, 58)];
     [path2 addLineToPoint: CGPointMake(225.5, 62)];
     [path2 addLineToPoint: CGPointMake(220.5, 63.5)];
     [path2 addLineToPoint: CGPointMake(215.5, 61)];
     [path2 addLineToPoint: CGPointMake(214, 55.5)];
     [path2 addLineToPoint: CGPointMake(217, 51)];
     [path2 closePath];


    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.frame = canvas.bounds;
    shapeLayer2.path = [path2 CGPath];
    shapeLayer2.strokeColor = [secondColor CGColor];
    shapeLayer2.lineWidth = 1.0;
    shapeLayer2.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *drawAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation2.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation2.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation2.duration = time;
    drawAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer2 addAnimation:drawAnimation2 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer2];
    
    
    // lines
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
     [path3 moveToPoint: CGPointMake(156, 114.5)];
     [path3 addLineToPoint: CGPointMake(162, 111.5)];
     [path3 addLineToPoint: CGPointMake(171.5, 106)];
     [path3 addLineToPoint: CGPointMake(181, 99)];
     [path3 addLineToPoint: CGPointMake(187.5, 92)];
     [path3 addLineToPoint: CGPointMake(191.5, 85)];
     [path3 addLineToPoint: CGPointMake(194, 79)];
     [path3 moveToPoint: CGPointMake(109.5, 93)];
     [path3 addLineToPoint: CGPointMake(102.5, 92.5)];
     [path3 addLineToPoint: CGPointMake(96.5, 90.5)];
     [path3 addLineToPoint: CGPointMake(91.5, 87.5)];
     [path3 moveToPoint: CGPointMake(120, 91.5)];
     [path3 addLineToPoint: CGPointMake(127.5, 89.5)];
     [path3 addLineToPoint: CGPointMake(135.5, 87)];
     [path3 addLineToPoint: CGPointMake(143.5, 82.5)];
     [path3 addCurveToPoint: CGPointMake(151, 77) controlPoint1: CGPointMake(145.83, 80.83) controlPoint2: CGPointMake(150.6, 77.4)];
     [path3 addCurveToPoint: CGPointMake(155.5, 72) controlPoint1: CGPointMake(151.4, 76.6) controlPoint2: CGPointMake(154.17, 73.5)];
     [path3 addLineToPoint: CGPointMake(157.5, 67.5)];
     [path3 moveToPoint: CGPointMake(97.5, 108.5)];
     [path3 addLineToPoint: CGPointMake(102, 109.5)];
     [path3 addLineToPoint: CGPointMake(109.5, 109)];
     [path3 addLineToPoint: CGPointMake(117.5, 108.5)];
     [path3 addLineToPoint: CGPointMake(124.5, 107)];
     [path3 addLineToPoint: CGPointMake(133, 105)];
     [path3 moveToPoint: CGPointMake(103, 128)];
     [path3 addCurveToPoint: CGPointMake(107, 127.5) controlPoint1: CGPointMake(103.4, 128) controlPoint2: CGPointMake(105.83, 127.67)];
     [path3 addLineToPoint: CGPointMake(111.5, 127)];
     [path3 addLineToPoint: CGPointMake(115.5, 126)];
     [path3 moveToPoint: CGPointMake(94.5, 127.5)];
     [path3 addLineToPoint: CGPointMake(87, 127)];
     [path3 addLineToPoint: CGPointMake(80, 124.5)];
     [path3 addCurveToPoint: CGPointMake(73.5, 121.5) controlPoint1: CGPointMake(78, 123.5) controlPoint2: CGPointMake(73.9, 121.5)];
     [path3 addCurveToPoint: CGPointMake(69, 119) controlPoint1: CGPointMake(73.1, 121.5) controlPoint2: CGPointMake(70.33, 119.83)];
     [path3 moveToPoint: CGPointMake(86.5, 166.5)];
     [path3 addLineToPoint: CGPointMake(78.5, 165)];
     [path3 addLineToPoint: CGPointMake(69.5, 161.5)];
     [path3 addLineToPoint: CGPointMake(60.5, 156)];
     [path3 moveToPoint: CGPointMake(106.5, 166.5)];
     [path3 addLineToPoint: CGPointMake(112, 166)];
     [path3 addLineToPoint: CGPointMake(116.5, 166)];
     [path3 addLineToPoint: CGPointMake(125.5, 164.5)];
     [path3 addLineToPoint: CGPointMake(136, 162)];
     [path3 addLineToPoint: CGPointMake(145.5, 159.5)];
     [path3 addLineToPoint: CGPointMake(155, 156.5)];
     [path3 addLineToPoint: CGPointMake(164.5, 153.5)];
     [path3 addLineToPoint: CGPointMake(174.5, 149)];
     [path3 addLineToPoint: CGPointMake(184, 144.5)];
     [path3 addLineToPoint: CGPointMake(192, 139.5)];
     [path3 addLineToPoint: CGPointMake(198, 135.5)];
     [path3 addLineToPoint: CGPointMake(203.5, 132)];
     [path3 moveToPoint: CGPointMake(212, 124)];
     [path3 addLineToPoint: CGPointMake(216, 119)];
     [path3 addLineToPoint: CGPointMake(219.5, 113)];
     [path3 addLineToPoint: CGPointMake(222.5, 105.5)];
     [path3 moveToPoint: CGPointMake(125.5, 145)];
     [path3 addLineToPoint: CGPointMake(133.5, 143)];
     [path3 addLineToPoint: CGPointMake(146.5, 139)];
     [path3 addLineToPoint: CGPointMake(155, 136)];
     [path3 addLineToPoint: CGPointMake(164, 132)];
     [path3 addLineToPoint: CGPointMake(171.5, 128.5)];
     [path3 addLineToPoint: CGPointMake(178, 125)];
     [path3 moveToPoint: CGPointMake(86.5, 184)];
     [path3 addLineToPoint: CGPointMake(93.5, 184.5)];
     [path3 addLineToPoint: CGPointMake(101, 184)];
     [path3 addLineToPoint: CGPointMake(109, 183.5)];
     [path3 moveToPoint: CGPointMake(190.5, 159.5)];
     [path3 addLineToPoint: CGPointMake(196.5, 157.5)];
     [path3 addLineToPoint: CGPointMake(204, 153)];
     [path3 addLineToPoint: CGPointMake(213, 146)];
     [path3 addLineToPoint: CGPointMake(219, 141.5)];
     [path3 addLineToPoint: CGPointMake(223, 137)];
     [path3 moveToPoint: CGPointMake(167, 213.5)];
     [path3 addLineToPoint: CGPointMake(171.5, 212.5)];
     [path3 addLineToPoint: CGPointMake(180.5, 209)];
     [path3 addLineToPoint: CGPointMake(188.5, 205.5)];
     [path3 addLineToPoint: CGPointMake(195, 202.5)];
     [path3 addLineToPoint: CGPointMake(201, 199.5)];
     [path3 addLineToPoint: CGPointMake(203.5, 196.5)];
     [path3 moveToPoint: CGPointMake(208.5, 209)];
     [path3 addLineToPoint: CGPointMake(214.5, 205.5)];
     [path3 addLineToPoint: CGPointMake(220, 201.5)];
     [path3 addLineToPoint: CGPointMake(227.5, 194)];
     [path3 moveToPoint: CGPointMake(198, 215)];
     [path3 addLineToPoint: CGPointMake(190.5, 218.5)];
     [path3 addLineToPoint: CGPointMake(180, 222.5)];
     [path3 addLineToPoint: CGPointMake(170, 226)];
     [path3 addLineToPoint: CGPointMake(159, 229)];
     [path3 addLineToPoint: CGPointMake(148.5, 231.5)];
     [path3 addLineToPoint: CGPointMake(134.5, 233)];
     [path3 addLineToPoint: CGPointMake(121, 233.5)];
     [path3 addLineToPoint: CGPointMake(109.5, 233)];

    
    CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.frame = canvas.bounds;
    shapeLayer3.path = [path3 CGPath];
    shapeLayer3.strokeColor = [thirdColor CGColor];
    shapeLayer3.lineWidth = 1.0;
    shapeLayer3.fillColor = [[UIColor clearColor] CGColor];

    CABasicAnimation *drawAnimation3 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation3.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation3.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation3.duration = time;
    drawAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer3 addAnimation:drawAnimation3 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer3];
    
    UIImage *planetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return planetImage;
    
}

- (UIImage *) drawTreeOnCanvas:(UIView *)canvas withDuration:(double)time withColor1:(UIColor *)firstColor withColor2:(UIColor *)secondColor withColor3:(UIColor *)thirdColor {
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
     [path1 moveToPoint:CGPointMake(213.19, 65.76)];
     [path1 addLineToPoint:CGPointMake(212.47, 65.08)];
     [path1 addLineToPoint:CGPointMake(211.64, 65.96)];
     [path1 addLineToPoint:CGPointMake(212.66, 66.61)];
     [path1 addLineToPoint:CGPointMake(213.19, 65.76)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(195.97, 42.55)];
     [path1 addLineToPoint:CGPointMake(194.97, 42.63)];
     [path1 addLineToPoint:CGPointMake(195.06, 43.81)];
     [path1 addLineToPoint:CGPointMake(196.21, 43.52)];
     [path1 addLineToPoint:CGPointMake(195.97, 42.55)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(171.6, 30.77)];
     [path1 addLineToPoint:CGPointMake(170.97, 31.55)];
     [path1 addLineToPoint:CGPointMake(171.46, 31.94)];
     [path1 addLineToPoint:CGPointMake(172.03, 31.67)];
     [path1 addLineToPoint:CGPointMake(171.6, 30.77)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(155.97, 27.55)];
     [path1 addLineToPoint:CGPointMake(154.97, 27.63)];
     [path1 addLineToPoint:CGPointMake(155.06, 28.81)];
     [path1 addLineToPoint:CGPointMake(156.21, 28.52)];
     [path1 addLineToPoint:CGPointMake(155.97, 27.55)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(125.59, 20.7)];
     [path1 addLineToPoint:CGPointMake(125.31, 21.66)];
     [path1 addLineToPoint:CGPointMake(125.99, 21.86)];
     [path1 addLineToPoint:CGPointMake(126.4, 21.29)];
     [path1 addLineToPoint:CGPointMake(125.59, 20.7)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(110.81, 22.77)];
     [path1 addLineToPoint:CGPointMake(110.52, 23.72)];
     [path1 addLineToPoint:CGPointMake(110.96, 23.85)];
     [path1 addLineToPoint:CGPointMake(111.34, 23.61)];
     [path1 addLineToPoint:CGPointMake(110.81, 22.77)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(91.59, 28.7)];
     [path1 addLineToPoint:CGPointMake(91.31, 29.66)];
     [path1 addLineToPoint:CGPointMake(91.98, 29.86)];
     [path1 addLineToPoint:CGPointMake(92.4, 29.29)];
     [path1 addLineToPoint:CGPointMake(91.59, 28.7)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(70.01, 43.02)];
     [path1 addLineToPoint:CGPointMake(70.72, 43.73)];
     [path1 addLineToPoint:CGPointMake(71.03, 43.42)];
     [path1 addLineToPoint:CGPointMake(71.01, 42.98)];
     [path1 addLineToPoint:CGPointMake(70.01, 43.02)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(68.59, 44.7)];
     [path1 addLineToPoint:CGPointMake(68.31, 45.66)];
     [path1 addLineToPoint:CGPointMake(68.98, 45.86)];
     [path1 addLineToPoint:CGPointMake(69.4, 45.29)];
     [path1 addLineToPoint:CGPointMake(68.59, 44.7)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(48.58, 64.71)];
     [path1 addLineToPoint:CGPointMake(49.39, 65.29)];
     [path1 addLineToPoint:CGPointMake(49.76, 64.79)];
     [path1 addLineToPoint:CGPointMake(49.46, 64.23)];
     [path1 addLineToPoint:CGPointMake(48.58, 64.71)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(47.19, 77.92)];
     [path1 addLineToPoint:CGPointMake(47.96, 78.57)];
     [path1 addLineToPoint:CGPointMake(48.37, 78.08)];
     [path1 addLineToPoint:CGPointMake(48.1, 77.51)];
     [path1 addLineToPoint:CGPointMake(47.19, 77.92)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(45.58, 92.71)];
     [path1 addLineToPoint:CGPointMake(46.39, 93.29)];
     [path1 addLineToPoint:CGPointMake(46.76, 92.79)];
     [path1 addLineToPoint:CGPointMake(46.46, 92.23)];
     [path1 addLineToPoint:CGPointMake(45.58, 92.71)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(61.68, 114.88)];
     [path1 addLineToPoint:CGPointMake(62.55, 114.39)];
     [path1 addLineToPoint:CGPointMake(62.22, 113.81)];
     [path1 addLineToPoint:CGPointMake(61.56, 113.88)];
     [path1 addLineToPoint:CGPointMake(61.68, 114.88)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(84.35, 121.26)];
     [path1 addLineToPoint:CGPointMake(85.25, 120.81)];
     [path1 addLineToPoint:CGPointMake(84.81, 119.93)];
     [path1 addLineToPoint:CGPointMake(83.92, 120.35)];
     [path1 addLineToPoint:CGPointMake(84.35, 121.26)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(101.68, 129.88)];
     [path1 addLineToPoint:CGPointMake(102.55, 129.39)];
     [path1 addLineToPoint:CGPointMake(102.22, 128.81)];
     [path1 addLineToPoint:CGPointMake(101.56, 128.88)];
     [path1 addLineToPoint:CGPointMake(101.68, 129.88)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(125, 135.93)];
     [path1 addLineToPoint:CGPointMake(125.47, 135.05)];
     [path1 addLineToPoint:CGPointMake(125, 134.8)];
     [path1 addLineToPoint:CGPointMake(124.53, 135.05)];
     [path1 addLineToPoint:CGPointMake(125, 135.93)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(129.66, 137.6)];
     [path1 addLineToPoint:CGPointMake(130.39, 136.93)];
     [path1 addLineToPoint:CGPointMake(130.18, 136.69)];
     [path1 addLineToPoint:CGPointMake(129.86, 136.63)];
     [path1 addLineToPoint:CGPointMake(129.66, 137.6)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(150.35, 141.26)];
     [path1 addLineToPoint:CGPointMake(151.25, 140.81)];
     [path1 addLineToPoint:CGPointMake(150.81, 139.93)];
     [path1 addLineToPoint:CGPointMake(149.92, 140.35)];
     [path1 addLineToPoint:CGPointMake(150.35, 141.26)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(167.68, 149.88)];
     [path1 addLineToPoint:CGPointMake(168.55, 149.39)];
     [path1 addLineToPoint:CGPointMake(168.22, 148.81)];
     [path1 addLineToPoint:CGPointMake(167.56, 148.88)];
     [path1 addLineToPoint:CGPointMake(167.68, 149.88)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(191, 155.93)];
     [path1 addLineToPoint:CGPointMake(191.47, 155.05)];
     [path1 addLineToPoint:CGPointMake(191, 154.8)];
     [path1 addLineToPoint:CGPointMake(190.53, 155.05)];
     [path1 addLineToPoint:CGPointMake(191, 155.93)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(215.99, 142.99)];
     [path1 addLineToPoint:CGPointMake(216.02, 141.99)];
     [path1 addLineToPoint:CGPointMake(214.95, 141.97)];
     [path1 addLineToPoint:CGPointMake(214.99, 143.03)];
     [path1 addLineToPoint:CGPointMake(215.99, 142.99)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(225, 140.93)];
     [path1 addLineToPoint:CGPointMake(225.47, 140.05)];
     [path1 addLineToPoint:CGPointMake(225, 139.8)];
     [path1 addLineToPoint:CGPointMake(224.53, 140.05)];
     [path1 addLineToPoint:CGPointMake(225, 140.93)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(249.66, 125.56)];
     [path1 addLineToPoint:CGPointMake(249.15, 124.7)];
     [path1 addLineToPoint:CGPointMake(248.52, 125.07)];
     [path1 addLineToPoint:CGPointMake(248.69, 125.79)];
     [path1 addLineToPoint:CGPointMake(249.66, 125.56)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(253.19, 104.24)];
     [path1 addLineToPoint:CGPointMake(252.66, 103.39)];
     [path1 addLineToPoint:CGPointMake(251.64, 104.04)];
     [path1 addLineToPoint:CGPointMake(252.47, 104.92)];
     [path1 addLineToPoint:CGPointMake(253.19, 104.24)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(238.97, 78.55)];
     [path1 addLineToPoint:CGPointMake(237.97, 78.63)];
     [path1 addLineToPoint:CGPointMake(238.06, 79.81)];
     [path1 addLineToPoint:CGPointMake(239.21, 79.52)];
     [path1 addLineToPoint:CGPointMake(238.97, 78.55)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(214.6, 66.77)];
     [path1 addLineToPoint:CGPointMake(213.97, 67.55)];
     [path1 addLineToPoint:CGPointMake(214.46, 67.94)];
     [path1 addLineToPoint:CGPointMake(215.03, 67.67)];
     [path1 addLineToPoint:CGPointMake(214.6, 66.77)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(213.92, 66.45)];
     [path1 addCurveToPoint:CGPointMake (218, 56.5) controlPoint1:CGPointMake(216.45, 63.77)controlPoint2:CGPointMake( 218, 60.3)];
     [path1 addLineToPoint:CGPointMake(216, 60)];
     [path1 addCurveToPoint:CGPointMake (212.47, 65.08) controlPoint1:CGPointMake(216, 59.74)controlPoint2:CGPointMake( 214.69, 62.73)];
     [path1 addLineToPoint:CGPointMake(213.92, 66.45)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(218, 56.5)];
     [path1 addCurveToPoint:CGPointMake (200.5, 41) controlPoint1:CGPointMake(218, 47.82)controlPoint2:CGPointMake( 210.04, 41)];
     [path1 addLineToPoint:CGPointMake(208, 43)];
     [path1 addCurveToPoint:CGPointMake (216, 56.5) controlPoint1:CGPointMake(209.19, 43)controlPoint2:CGPointMake( 216, 49.16)];
     [path1 addLineToPoint:CGPointMake(218, 50)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(200.5, 41)];
     [path1 addCurveToPoint:CGPointMake (195.72, 41.58) controlPoint1:CGPointMake(198.85, 41)controlPoint2:CGPointMake( 197.24, 41.2)];
     [path1 addLineToPoint:CGPointMake(196.21, 43.52)];
     [path1 addCurveToPoint:CGPointMake (200.5, 43) controlPoint1:CGPointMake(197.57, 43.18)controlPoint2:CGPointMake( 199.01, 43)];
     [path1 addLineToPoint:CGPointMake(198, 41)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(196.96, 42.48)];
     [path1 addCurveToPoint:CGPointMake (179.5, 28) controlPoint1:CGPointMake(196.36, 34.29)controlPoint2:CGPointMake( 188.67, 28)];
     [path1 addLineToPoint:CGPointMake(185, 30)];
     [path1 addCurveToPoint:CGPointMake (194.97, 42.63) controlPoint1:CGPointMake(187.84, 30)controlPoint2:CGPointMake( 194.46, 35.68)];
     [path1 addLineToPoint:CGPointMake(196.96, 42.48)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(179.5, 28)];
     [path1 addCurveToPoint:CGPointMake (171.16, 29.87) controlPoint1:CGPointMake(176.49, 28)controlPoint2:CGPointMake( 173.65, 28.67)];
     [path1 addLineToPoint:CGPointMake(172.03, 31.67)];
     [path1 addCurveToPoint:CGPointMake (179.5, 30) controlPoint1:CGPointMake(174.24, 30.61)controlPoint2:CGPointMake( 176.79, 30)];
     [path1 addLineToPoint:CGPointMake(175, 28)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(172.22, 29.99)];
     [path1 addCurveToPoint:CGPointMake (160.5, 26) controlPoint1:CGPointMake(169.11, 27.5)controlPoint2:CGPointMake( 165, 26)];
     [path1 addLineToPoint:CGPointMake(165, 28)];
     [path1 addCurveToPoint:CGPointMake (170.97, 31.55) controlPoint1:CGPointMake(164.55, 28)controlPoint2:CGPointMake( 168.22, 29.35)];
     [path1 addLineToPoint:CGPointMake(172.22, 29.99)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(160.5, 26)];
     [path1 addCurveToPoint:CGPointMake (155.72, 26.58) controlPoint1:CGPointMake(158.85, 26)controlPoint2:CGPointMake( 157.24, 26.2)];
     [path1 addLineToPoint:CGPointMake(156.21, 28.52)];
     [path1 addCurveToPoint:CGPointMake (160.5, 28) controlPoint1:CGPointMake(157.57, 28.18)controlPoint2:CGPointMake( 159.01, 28)];
     [path1 addLineToPoint:CGPointMake(158, 26)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(156.96, 27.48)];
     [path1 addCurveToPoint:CGPointMake (139.5, 13) controlPoint1:CGPointMake(156.36, 19.29)controlPoint2:CGPointMake( 148.67, 13)];
     [path1 addLineToPoint:CGPointMake(145, 15)];
     [path1 addCurveToPoint:CGPointMake (154.97, 27.63) controlPoint1:CGPointMake(147.84, 15)controlPoint2:CGPointMake( 154.46, 20.68)];
     [path1 addLineToPoint:CGPointMake(156.96, 27.48)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(139.5, 13)];
     [path1 addCurveToPoint:CGPointMake (124.78, 20.11) controlPoint1:CGPointMake(133.35, 13)controlPoint2:CGPointMake( 127.91, 15.81)];
     [path1 addLineToPoint:CGPointMake(126.4, 21.29)];
     [path1 addCurveToPoint:CGPointMake (139.5, 15) controlPoint1:CGPointMake(129.13, 17.54)controlPoint2:CGPointMake( 133.95, 15)];
     [path1 addLineToPoint:CGPointMake(133, 13)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(125.86, 19.74)];
     [path1 addCurveToPoint:CGPointMake (120.5, 19) controlPoint1:CGPointMake(124.17, 19.26)controlPoint2:CGPointMake( 122.37, 19)];
     [path1 addLineToPoint:CGPointMake(123, 21)];
     [path1 addCurveToPoint:CGPointMake (125.31, 21.66) controlPoint1:CGPointMake(122.18, 21)controlPoint2:CGPointMake( 123.8, 21.23)];
     [path1 addLineToPoint:CGPointMake(125.86, 19.74)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(120.5, 19)];
     [path1 addCurveToPoint:CGPointMake (110.27, 21.92) controlPoint1:CGPointMake(116.69, 19)controlPoint2:CGPointMake( 113.15, 20.08)];
     [path1 addLineToPoint:CGPointMake(111.34, 23.61)];
     [path1 addCurveToPoint:CGPointMake (120.5, 21) controlPoint1:CGPointMake(113.9, 21.97)controlPoint2:CGPointMake( 117.07, 21)];
     [path1 addLineToPoint:CGPointMake(115, 19)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(111.09, 21.81)];
     [path1 addCurveToPoint:CGPointMake (105.5, 21) controlPoint1:CGPointMake(109.33, 21.28)controlPoint2:CGPointMake( 107.45, 21)];
     [path1 addLineToPoint:CGPointMake(107.5, 23)];
     [path1 addCurveToPoint:CGPointMake (110.52, 23.72) controlPoint1:CGPointMake(107.26, 23)controlPoint2:CGPointMake( 108.95, 23.26)];
     [path1 addLineToPoint:CGPointMake(111.09, 21.81)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(105.5, 21)];
     [path1 addCurveToPoint:CGPointMake (90.78, 28.11) controlPoint1:CGPointMake(99.35, 21)controlPoint2:CGPointMake( 93.91, 23.81)];
     [path1 addLineToPoint:CGPointMake(92.4, 29.29)];
     [path1 addCurveToPoint:CGPointMake (105.5, 23) controlPoint1:CGPointMake(95.13, 25.54)controlPoint2:CGPointMake( 99.95, 23)];
     [path1 addLineToPoint:CGPointMake(96, 21)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(91.86, 27.74)];
     [path1 addCurveToPoint:CGPointMake (86.5, 27) controlPoint1:CGPointMake(90.17, 27.26)controlPoint2:CGPointMake( 88.37, 27)];
     [path1 addLineToPoint:CGPointMake(89, 29)];
     [path1 addCurveToPoint:CGPointMake (91.31, 29.66) controlPoint1:CGPointMake(88.18, 29)controlPoint2:CGPointMake( 89.8, 29.23)];
     [path1 addLineToPoint:CGPointMake(91.86, 27.74)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(86.5, 27)];
     [path1 addCurveToPoint:CGPointMake (69, 42.5) controlPoint1:CGPointMake(76.96, 27)controlPoint2:CGPointMake( 69, 33.82)];
     [path1 addLineToPoint:CGPointMake(71, 35)];
     [path1 addCurveToPoint:CGPointMake (86.5, 29) controlPoint1:CGPointMake(71, 35.16)controlPoint2:CGPointMake( 77.81, 29)];
     [path1 addLineToPoint:CGPointMake(75, 27)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(69, 42.5)];
     [path1 addCurveToPoint:CGPointMake (69.01, 43.06) controlPoint1:CGPointMake(69, 42.69)controlPoint2:CGPointMake( 69, 42.88)];
     [path1 addLineToPoint:CGPointMake(71.01, 42.98)];
     [path1 addCurveToPoint:CGPointMake (71, 42.5) controlPoint1:CGPointMake(71, 42.82)controlPoint2:CGPointMake( 71, 42.66)];
     [path1 addLineToPoint:CGPointMake(69, 42.4)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(69.3, 42.32)];
     [path1 addCurveToPoint:CGPointMake (67.78, 44.11) controlPoint1:CGPointMake(68.75, 42.88)controlPoint2:CGPointMake( 68.24, 43.48)];
     [path1 addLineToPoint:CGPointMake(69.4, 45.29)];
     [path1 addCurveToPoint:CGPointMake (70.72, 43.73) controlPoint1:CGPointMake(69.79, 44.74)controlPoint2:CGPointMake( 70.24, 44.22)];
     [path1 addLineToPoint:CGPointMake(69.3, 42.32)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(68.86, 43.74)];
     [path1 addCurveToPoint:CGPointMake (63.5, 43) controlPoint1:CGPointMake(67.17, 43.26)controlPoint2:CGPointMake( 65.37, 43)];
     [path1 addLineToPoint:CGPointMake(66, 45)];
     [path1 addCurveToPoint:CGPointMake (68.31, 45.66) controlPoint1:CGPointMake(65.18, 45)controlPoint2:CGPointMake( 66.8, 45.23)];
     [path1 addLineToPoint:CGPointMake(68.86, 43.74)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(63.5, 43)];
     [path1 addCurveToPoint:CGPointMake (46, 58.5) controlPoint1:CGPointMake(53.96, 43)controlPoint2:CGPointMake( 46, 49.82)];
     [path1 addLineToPoint:CGPointMake(48, 52)];
     [path1 addCurveToPoint:CGPointMake (63.5, 45) controlPoint1:CGPointMake(48, 51.16)controlPoint2:CGPointMake( 54.81, 45)];
     [path1 addLineToPoint:CGPointMake(55, 43)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(46, 58.5)];
     [path1 addCurveToPoint:CGPointMake (47.7, 65.18) controlPoint1:CGPointMake(46, 60.89)controlPoint2:CGPointMake( 46.61, 63.16)];
     [path1 addLineToPoint:CGPointMake(49.46, 64.23)];
     [path1 addCurveToPoint:CGPointMake (48, 58.5) controlPoint1:CGPointMake(48.52, 62.49)controlPoint2:CGPointMake( 48, 60.55)];
     [path1 addLineToPoint:CGPointMake(46, 61)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(47.77, 64.12)];
     [path1 addCurveToPoint:CGPointMake (45, 72.5) controlPoint1:CGPointMake(46.02, 66.53)controlPoint2:CGPointMake( 45, 69.4)];
     [path1 addLineToPoint:CGPointMake(47, 68)];
     [path1 addCurveToPoint:CGPointMake (49.39, 65.29) controlPoint1:CGPointMake(47, 69.86)controlPoint2:CGPointMake( 47.87, 67.39)];
     [path1 addLineToPoint:CGPointMake(47.77, 64.12)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(45, 72.5)];
     [path1 addCurveToPoint:CGPointMake (46.28, 78.34) controlPoint1:CGPointMake(45, 74.57)controlPoint2:CGPointMake( 45.46, 76.54)];
     [path1 addLineToPoint:CGPointMake(48.1, 77.51)];
     [path1 addCurveToPoint:CGPointMake (47, 72.5) controlPoint1:CGPointMake(47.39, 75.96)controlPoint2:CGPointMake( 47, 74.27)];
     [path1 addLineToPoint:CGPointMake(45, 74)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(46.43, 77.28)];
     [path1 addCurveToPoint:CGPointMake (43, 86.5) controlPoint1:CGPointMake(44.28, 79.85)controlPoint2:CGPointMake( 43, 83.04)];
     [path1 addLineToPoint:CGPointMake(45, 82)];
     [path1 addCurveToPoint:CGPointMake (47.96, 78.57) controlPoint1:CGPointMake(45, 83.55)controlPoint2:CGPointMake( 46.09, 80.8)];
     [path1 addLineToPoint:CGPointMake(46.43, 77.28)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(43, 86.5)];
     [path1 addCurveToPoint:CGPointMake (44.7, 93.18) controlPoint1:CGPointMake(43, 88.89)controlPoint2:CGPointMake( 43.61, 91.16)];
     [path1 addLineToPoint:CGPointMake(46.46, 92.23)];
     [path1 addCurveToPoint:CGPointMake (45, 86.5) controlPoint1:CGPointMake(45.52, 90.49)controlPoint2:CGPointMake( 45, 88.55)];
     [path1 addLineToPoint:CGPointMake(43, 89)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(44.77, 92.12)];
     [path1 addCurveToPoint:CGPointMake (42, 100.5) controlPoint1:CGPointMake(43.02, 94.53)controlPoint2:CGPointMake( 42, 97.4)];
     [path1 addLineToPoint:CGPointMake(44, 97)];
     [path1 addCurveToPoint:CGPointMake (46.39, 93.29) controlPoint1:CGPointMake(44, 97.86)controlPoint2:CGPointMake( 44.87, 95.39)];
     [path1 addLineToPoint:CGPointMake(44.77, 92.12)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(42, 100.5)];
     [path1 addCurveToPoint:CGPointMake (59.5, 116) controlPoint1:CGPointMake(42, 109.18)controlPoint2:CGPointMake( 49.96, 116)];
     [path1 addLineToPoint:CGPointMake(51, 114)];
     [path1 addCurveToPoint:CGPointMake (44, 100.5) controlPoint1:CGPointMake(50.81, 114)controlPoint2:CGPointMake( 44, 107.84)];
     [path1 addLineToPoint:CGPointMake(42, 113)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(59.5, 116)];
     [path1 addCurveToPoint:CGPointMake (61.79, 115.87) controlPoint1:CGPointMake(60.28, 116)controlPoint2:CGPointMake( 61.04, 115.96)];
     [path1 addLineToPoint:CGPointMake(61.56, 113.88)];
     [path1 addCurveToPoint:CGPointMake (59.5, 114) controlPoint1:CGPointMake(60.89, 113.96)controlPoint2:CGPointMake( 60.2, 114)];
     [path1 addLineToPoint:CGPointMake(60.1, 116)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(60.8, 115.36)];
     [path1 addCurveToPoint:CGPointMake (76.5, 124) controlPoint1:CGPointMake(63.68, 120.52)controlPoint2:CGPointMake( 69.66, 124)];
     [path1 addLineToPoint:CGPointMake(68, 122)];
     [path1 addCurveToPoint:CGPointMake (62.55, 114.39) controlPoint1:CGPointMake(70.32, 122)controlPoint2:CGPointMake( 65.04, 118.86)];
     [path1 addLineToPoint:CGPointMake(60.8, 115.36)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(76.5, 124)];
     [path1 addCurveToPoint:CGPointMake (84.78, 122.16) controlPoint1:CGPointMake(79.49, 124)controlPoint2:CGPointMake( 82.31, 123.34)];
     [path1 addLineToPoint:CGPointMake(83.92, 120.35)];
     [path1 addCurveToPoint:CGPointMake (76.5, 122) controlPoint1:CGPointMake(81.72, 121.4)controlPoint2:CGPointMake( 79.19, 122)];
     [path1 addLineToPoint:CGPointMake(80, 124)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(83.45, 121.7)];
     [path1 addCurveToPoint:CGPointMake (99.5, 131) controlPoint1:CGPointMake(86.17, 127.22)controlPoint2:CGPointMake( 92.37, 131)];
     [path1 addLineToPoint:CGPointMake(92, 129)];
     [path1 addCurveToPoint:CGPointMake (85.25, 120.81) controlPoint1:CGPointMake(93.06, 129)controlPoint2:CGPointMake( 87.6, 125.58)];
     [path1 addLineToPoint:CGPointMake(83.45, 121.7)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(99.5, 131)];
     [path1 addCurveToPoint:CGPointMake (101.79, 130.87) controlPoint1:CGPointMake(100.28, 131)controlPoint2:CGPointMake( 101.04, 130.96)];
     [path1 addLineToPoint:CGPointMake(101.56, 128.88)];
     [path1 addCurveToPoint:CGPointMake (99.5, 129) controlPoint1:CGPointMake(100.89, 128.96)controlPoint2:CGPointMake( 100.2, 129)];
     [path1 addLineToPoint:CGPointMake(100.1, 131)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(100.8, 130.36)];
     [path1 addCurveToPoint:CGPointMake (116.5, 139) controlPoint1:CGPointMake(103.68, 135.52)controlPoint2:CGPointMake( 109.66, 139)];
     [path1 addLineToPoint:CGPointMake(107, 137)];
     [path1 addCurveToPoint:CGPointMake (102.55, 129.39) controlPoint1:CGPointMake(110.32, 137)controlPoint2:CGPointMake( 105.04, 133.85)];
     [path1 addLineToPoint:CGPointMake(100.8, 130.36)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(116.5, 139)];
     [path1 addCurveToPoint:CGPointMake (125.47, 136.81) controlPoint1:CGPointMake(119.77, 139)controlPoint2:CGPointMake( 122.84, 138.21)];
     [path1 addLineToPoint:CGPointMake(124.53, 135.05)];
     [path1 addCurveToPoint:CGPointMake (116.5, 137) controlPoint1:CGPointMake(122.2, 136.28)controlPoint2:CGPointMake( 119.45, 137)];
     [path1 addLineToPoint:CGPointMake(120, 139)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(124.53, 136.81)];
     [path1 addCurveToPoint:CGPointMake (129.45, 138.58) controlPoint1:CGPointMake(126.04, 137.61)controlPoint2:CGPointMake( 127.7, 138.22)];
     [path1 addLineToPoint:CGPointMake(129.86, 136.63)];
     [path1 addCurveToPoint:CGPointMake (125.47, 135.05) controlPoint1:CGPointMake(128.29, 136.3)controlPoint2:CGPointMake( 126.81, 135.76)];
     [path1 addLineToPoint:CGPointMake(124.53, 136.81)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(128.92, 138.28)];
     [path1 addCurveToPoint:CGPointMake (142.5, 144) controlPoint1:CGPointMake(132.14, 141.79)controlPoint2:CGPointMake( 137.04, 144)];
     [path1 addLineToPoint:CGPointMake(137, 142)];
     [path1 addCurveToPoint:CGPointMake (130.39, 136.93) controlPoint1:CGPointMake(137.58, 142)controlPoint2:CGPointMake( 133.22, 140)];
     [path1 addLineToPoint:CGPointMake(128.92, 138.28)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(142.5, 144)];
     [path1 addCurveToPoint:CGPointMake (150.78, 142.16) controlPoint1:CGPointMake(145.49, 144)controlPoint2:CGPointMake( 148.31, 143.34)];
     [path1 addLineToPoint:CGPointMake(149.92, 140.35)];
     [path1 addCurveToPoint:CGPointMake (142.5, 142) controlPoint1:CGPointMake(147.72, 141.4)controlPoint2:CGPointMake( 145.19, 142)];
     [path1 addLineToPoint:CGPointMake(144, 144)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(149.45, 141.7)];
     [path1 addCurveToPoint:CGPointMake (165.5, 151) controlPoint1:CGPointMake(152.17, 147.22)controlPoint2:CGPointMake( 158.37, 151)];
     [path1 addLineToPoint:CGPointMake(159, 149)];
     [path1 addCurveToPoint:CGPointMake (151.25, 140.81) controlPoint1:CGPointMake(159.06, 149)controlPoint2:CGPointMake( 153.6, 145.58)];
     [path1 addLineToPoint:CGPointMake(149.45, 141.7)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(165.5, 151)];
     [path1 addCurveToPoint:CGPointMake (167.79, 150.87) controlPoint1:CGPointMake(166.28, 151)controlPoint2:CGPointMake( 167.04, 150.96)];
     [path1 addLineToPoint:CGPointMake(167.56, 148.88)];
     [path1 addCurveToPoint:CGPointMake (165.5, 149) controlPoint1:CGPointMake(166.89, 148.96)controlPoint2:CGPointMake( 166.2, 149)];
     [path1 addLineToPoint:CGPointMake(166.1, 151)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(166.8, 150.36)];
     [path1 addCurveToPoint:CGPointMake (182.5, 159) controlPoint1:CGPointMake(169.68, 155.52)controlPoint2:CGPointMake( 175.66, 159)];
     [path1 addLineToPoint:CGPointMake(170, 157)];
     [path1 addCurveToPoint:CGPointMake (168.55, 149.39) controlPoint1:CGPointMake(176.32, 157)controlPoint2:CGPointMake( 171.04, 153.85)];
     [path1 addLineToPoint:CGPointMake(166.8, 150.36)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(182.5, 159)];
     [path1 addCurveToPoint:CGPointMake (191.47, 156.81) controlPoint1:CGPointMake(185.77, 159)controlPoint2:CGPointMake( 188.84, 158.21)];
     [path1 addLineToPoint:CGPointMake(190.53, 155.05)];
     [path1 addCurveToPoint:CGPointMake (182.5, 157) controlPoint1:CGPointMake(188.2, 156.28)controlPoint2:CGPointMake( 185.45, 157)];
     [path1 addLineToPoint:CGPointMake(185.5, 159)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(190.53, 156.81)];
     [path1 addCurveToPoint:CGPointMake (199.5, 159) controlPoint1:CGPointMake(193.16, 158.21)controlPoint2:CGPointMake( 196.23, 159)];
     [path1 addLineToPoint:CGPointMake(195, 157)];
     [path1 addCurveToPoint:CGPointMake (191.47, 155.05) controlPoint1:CGPointMake(196.55, 157)controlPoint2:CGPointMake( 193.81, 156.28)];
     [path1 addLineToPoint:CGPointMake(190.53, 156.81)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(199.5, 159)];
     [path1 addCurveToPoint:CGPointMake (217, 143.5) controlPoint1:CGPointMake(209.04, 159)controlPoint2:CGPointMake( 217, 152.18)];
     [path1 addLineToPoint:CGPointMake(215, 149)];
     [path1 addCurveToPoint:CGPointMake (199.5, 157) controlPoint1:CGPointMake(215, 150.84)controlPoint2:CGPointMake( 208.19, 157)];
     [path1 addLineToPoint:CGPointMake(204, 159)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(217, 143.5)];
     [path1 addCurveToPoint:CGPointMake (216.99, 142.95) controlPoint1:CGPointMake(217, 143.32)controlPoint2:CGPointMake( 217, 143.14)];
     [path1 addLineToPoint:CGPointMake(214.99, 143.03)];
     [path1 addCurveToPoint:CGPointMake (215, 143.5) controlPoint1:CGPointMake(215, 143.19)controlPoint2:CGPointMake( 215, 143.34)];
     [path1 addLineToPoint:CGPointMake(217, 143.7)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(215.96, 143.99)];
     [path1 addCurveToPoint:CGPointMake (216.5, 144) controlPoint1:CGPointMake(216.14, 144)controlPoint2:CGPointMake( 216.32, 144)];
     [path1 addLineToPoint:CGPointMake(215, 142)];
     [path1 addCurveToPoint:CGPointMake (216.02, 141.99) controlPoint1:CGPointMake(216.34, 142)controlPoint2:CGPointMake( 216.18, 142)];
     [path1 addLineToPoint:CGPointMake(215.96, 143.99)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(216.5, 144)];
     [path1 addCurveToPoint:CGPointMake (225.47, 141.81) controlPoint1:CGPointMake(219.77, 144)controlPoint2:CGPointMake( 222.84, 143.21)];
     [path1 addLineToPoint:CGPointMake(224.53, 140.05)];
     [path1 addCurveToPoint:CGPointMake (216.5, 142) controlPoint1:CGPointMake(222.2, 141.28)controlPoint2:CGPointMake( 219.45, 142)];
     [path1 addLineToPoint:CGPointMake(220, 144)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(224.53, 141.81)];
     [path1 addCurveToPoint:CGPointMake (233.5, 144) controlPoint1:CGPointMake(227.16, 143.21)controlPoint2:CGPointMake( 230.23, 144)];
     [path1 addLineToPoint:CGPointMake(229, 142)];
     [path1 addCurveToPoint:CGPointMake (225.47, 140.05) controlPoint1:CGPointMake(230.55, 142)controlPoint2:CGPointMake( 227.81, 141.28)];
     [path1 addLineToPoint:CGPointMake(224.53, 141.81)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(233.5, 144)];
     [path1 addCurveToPoint:CGPointMake (251, 128.5) controlPoint1:CGPointMake(243.04, 144)controlPoint2:CGPointMake( 251, 137.18)];
     [path1 addLineToPoint:CGPointMake(249, 135)];
     [path1 addCurveToPoint:CGPointMake (233.5, 142) controlPoint1:CGPointMake(249, 135.84)controlPoint2:CGPointMake( 242.19, 142)];
     [path1 addLineToPoint:CGPointMake(241, 144)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(251, 128.5)];
     [path1 addCurveToPoint:CGPointMake (250.64, 125.33) controlPoint1:CGPointMake(251, 127.42)controlPoint2:CGPointMake( 250.87, 126.36)];
     [path1 addLineToPoint:CGPointMake(248.69, 125.79)];
     [path1 addCurveToPoint:CGPointMake (249, 128.5) controlPoint1:CGPointMake(248.89, 126.67)controlPoint2:CGPointMake( 249, 127.57)];
     [path1 addLineToPoint:CGPointMake(251, 127.5)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(250.17, 126.42)];
     [path1 addCurveToPoint:CGPointMake (258, 113.5) controlPoint1:CGPointMake(254.85, 123.67)controlPoint2:CGPointMake( 258, 118.94)];
     [path1 addLineToPoint:CGPointMake(256, 118)];
     [path1 addCurveToPoint:CGPointMake (249.15, 124.7) controlPoint1:CGPointMake(256, 118.12)controlPoint2:CGPointMake( 253.32, 122.25)];
     [path1 addLineToPoint:CGPointMake(250.17, 126.42)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(258, 113.5)];
     [path1 addCurveToPoint:CGPointMake (253.92, 103.55) controlPoint1:CGPointMake(258, 109.7)controlPoint2:CGPointMake( 256.45, 106.23)];
     [path1 addLineToPoint:CGPointMake(252.47, 104.92)];
     [path1 addCurveToPoint:CGPointMake (256, 113.5) controlPoint1:CGPointMake(254.69, 107.27)controlPoint2:CGPointMake( 256, 110.26)];
     [path1 addLineToPoint:CGPointMake(258, 109)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(253.73, 105.08)];
     [path1 addCurveToPoint:CGPointMake (261, 92.5) controlPoint1:CGPointMake(258.1, 102.29)controlPoint2:CGPointMake( 261, 97.72)];
     [path1 addLineToPoint:CGPointMake(259, 97)];
     [path1 addCurveToPoint:CGPointMake (252.66, 103.39) controlPoint1:CGPointMake(259, 96.93)controlPoint2:CGPointMake( 256.54, 100.91)];
     [path1 addLineToPoint:CGPointMake(253.73, 105.08)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(261, 92.5)];
     [path1 addCurveToPoint:CGPointMake (243.5, 77) controlPoint1:CGPointMake(261, 83.82)controlPoint2:CGPointMake( 253.04, 77)];
     [path1 addLineToPoint:CGPointMake(251, 79)];
     [path1 addCurveToPoint:CGPointMake (259, 92.5) controlPoint1:CGPointMake(252.19, 79)controlPoint2:CGPointMake( 259, 85.16)];
     [path1 addLineToPoint:CGPointMake(261, 85)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(243.5, 77)];
     [path1 addCurveToPoint:CGPointMake (238.72, 77.58) controlPoint1:CGPointMake(241.85, 77)controlPoint2:CGPointMake( 240.24, 77.2)];
     [path1 addLineToPoint:CGPointMake(239.21, 79.52)];
     [path1 addCurveToPoint:CGPointMake (243.5, 79) controlPoint1:CGPointMake(240.57, 79.18)controlPoint2:CGPointMake( 242.01, 79)];
     [path1 addLineToPoint:CGPointMake(241, 77)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(239.96, 78.48)];
     [path1 addCurveToPoint:CGPointMake (222.5, 64) controlPoint1:CGPointMake(239.36, 70.29)controlPoint2:CGPointMake( 231.67, 64)];
     [path1 addLineToPoint:CGPointMake(230, 66)];
     [path1 addCurveToPoint:CGPointMake (237.97, 78.63) controlPoint1:CGPointMake(230.84, 66)controlPoint2:CGPointMake( 237.46, 71.68)];
     [path1 addLineToPoint:CGPointMake(239.96, 78.48)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(222.5, 64)];
     [path1 addCurveToPoint:CGPointMake (214.16, 65.87) controlPoint1:CGPointMake(219.49, 64)controlPoint2:CGPointMake( 216.65, 64.67)];
     [path1 addLineToPoint:CGPointMake(215.03, 67.67)];
     [path1 addCurveToPoint:CGPointMake (222.5, 66) controlPoint1:CGPointMake(217.24, 66.61)controlPoint2:CGPointMake( 219.79, 66)];
     [path1 addLineToPoint:CGPointMake(217, 64)];
     [path1 closePath];
     [path1 moveToPoint:CGPointMake(215.22, 65.99)];
     [path1 addCurveToPoint:CGPointMake (213.73, 64.92) controlPoint1:CGPointMake(214.75, 65.61)controlPoint2:CGPointMake( 214.25, 65.25)];
     [path1 addLineToPoint:CGPointMake(212.66, 66.61)];
     [path1 addCurveToPoint:CGPointMake (213.97, 67.55) controlPoint1:CGPointMake(213.11, 66.9)controlPoint2:CGPointMake( 213.55, 67.22)];
     [path1 addLineToPoint:CGPointMake(215.22, 65.99)];
     [path1 closePath];

    
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.frame = canvas.bounds;
    shapeLayer1.path = [path1 CGPath];
    shapeLayer1.strokeColor = [firstColor CGColor];
    shapeLayer1.lineWidth = 1.0;
    shapeLayer1.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *drawAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation1.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation1.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation1.duration = time;
    drawAnimation1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer1 addAnimation:drawAnimation1 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer1];
    
    
    // trunk
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
     [path2 moveToPoint:CGPointMake(82, 250.5)];
     [path2 addCurveToPoint:CGPointMake (143.5, 187.5) controlPoint1: CGPointMake(101.83, 244.67) controlPoint2: CGPointMake(141.9, 223.9)];
     [path2 addCurveToPoint:CGPointMake (133.5, 140.5) controlPoint1: CGPointMake(145.1, 151.1) controlPoint2: CGPointMake(137.5, 141)];
     [path2 moveToPoint:CGPointMake(225.5, 256)];
     [path2 addCurveToPoint:CGPointMake (172, 227) controlPoint1: CGPointMake(207.17, 255) controlPoint2: CGPointMake(170.8, 247.8)];
     [path2 addCurveToPoint:CGPointMake (183, 168.5) controlPoint1: CGPointMake(173.2, 206.2) controlPoint2: CGPointMake(179.83, 179.33)];
     [path2 addCurveToPoint:CGPointMake (192.5, 156.5) controlPoint1: CGPointMake(185.17, 164.17) controlPoint2: CGPointMake(190.1, 155.7)];
     [path2 moveToPoint:CGPointMake(158.5, 165)];
     [path2 addCurveToPoint:CGPointMake (151, 214) controlPoint1: CGPointMake(157, 180.17) controlPoint2: CGPointMake(153.4, 211.2)];
     [path2 moveToPoint:CGPointMake(163.5, 239.5)];
     [path2 addCurveToPoint:CGPointMake (168.5, 168.5) controlPoint1: CGPointMake(163.5, 231.5) controlPoint2: CGPointMake(162.5, 183)];
     [path2 moveToPoint:CGPointMake(145, 207.5)];
     [path2 addCurveToPoint:CGPointMake (124.5, 236.5) controlPoint1: CGPointMake(132, 226.5) controlPoint2: CGPointMake(130.5, 231)];
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.frame = canvas.bounds;
    shapeLayer2.path = [path2 CGPath];
    shapeLayer2.strokeColor = [secondColor CGColor];
    shapeLayer2.lineWidth = 1.0;
    shapeLayer2.fillColor = [[UIColor clearColor] CGColor];
    
    CABasicAnimation *drawAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation2.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation2.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation2.duration = time;
    drawAnimation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer2 addAnimation:drawAnimation2 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer2];
    
    // ground
    
    UIBezierPath *path3 = [UIBezierPath bezierPath];
     [path3 moveToPoint: CGPointMake(99.5, 243.5)];
     [path3 addCurveToPoint:CGPointMake(66, 248.81) controlPoint1: CGPointMake(91.5, 235) controlPoint2: CGPointMake(76.4, 235.61)];
     [path3 moveToPoint: CGPointMake(39.5, 255)];
     [path3 addCurveToPoint:CGPointMake(63.5, 248) controlPoint1: CGPointMake(42.83, 251.17) controlPoint2: CGPointMake(52.3, 244.4)];
     [path3 addCurveToPoint:CGPointMake(74, 252) controlPoint1: CGPointMake(74.7, 251.6) controlPoint2: CGPointMake(75.17, 252.17)];
     [path3 moveToPoint: CGPointMake(178, 240.5)];
     [path3 addCurveToPoint:CGPointMake(201.5, 240.5) controlPoint1: CGPointMake(183, 237.73) controlPoint2: CGPointMake(194.7, 233.85)];
     [path3 addCurveToPoint:CGPointMake(206.74, 246.5) controlPoint1: CGPointMake(203.78, 242.73) controlPoint2: CGPointMake(205.48, 244.74)];
     [path3 moveToPoint: CGPointMake(210, 253.5)];
     [path3 addCurveToPoint:CGPointMake(206.74, 246.5) controlPoint1: CGPointMake(210, 252.46) controlPoint2: CGPointMake(209.25, 249.99)];
     [path3 moveToPoint: CGPointMake(206.74, 246.5)];
     [path3 addCurveToPoint:CGPointMake(241.5, 248) controlPoint1: CGPointMake(218.33, 243.33) controlPoint2: CGPointMake(241.5, 239.2)];
     [path3 addCurveToPoint:CGPointMake(224.5, 256) controlPoint1: CGPointMake(241.5, 256.8) controlPoint2: CGPointMake(225.83, 255.17)];
    
    CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.frame = canvas.bounds;
    shapeLayer3.path = [path3 CGPath];
    shapeLayer3.strokeColor = [thirdColor CGColor];
    shapeLayer3.lineWidth = 1.0;
    shapeLayer3.fillColor = [[UIColor clearColor] CGColor];

    CABasicAnimation *drawAnimation3 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation3.fromValue = (id)[NSNumber numberWithFloat:0.10];
    drawAnimation3.toValue = (id)[NSNumber numberWithFloat:1.f];
    drawAnimation3.duration = time;
    drawAnimation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [shapeLayer3 addAnimation:drawAnimation3 forKey:@"drawRectStroke"];

    [canvas.layer addSublayer:shapeLayer3];
    
    UIImage *treeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return treeImage;
}

@end
