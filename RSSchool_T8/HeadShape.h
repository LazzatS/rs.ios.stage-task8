//
//  HeadShape.h
//  RSSchool_T8
//
//  Created by Lazzat Seiilova on 19.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeadShape : UIView

@end

NS_ASSUME_NONNULL_END


/*
 // face
 UIBezierPath *path = [UIBezierPath bezierPath];
 [path moveToPoint:CGPointMake(61.5, 29)];
 [path addLineToPoint:CGPointMake(77, 89)];
 [path addLineToPoint:CGPointMake(89, 112)];
 [path addLineToPoint:CGPointMake(106.5, 131.5)];
 [path addLineToPoint:CGPointMake(133.5, 154)];
 [path addLineToPoint:CGPointMake(157, 159.5)];
 [path addLineToPoint:CGPointMake(193, 142)];
 [path addLineToPoint:CGPointMake(220, 112)];
 [path addLineToPoint:CGPointMake(228.5, 100)];
 [path addLineToPoint:CGPointMake(229, 77.5)];
 [path addLineToPoint:CGPointMake(230.5, 50.5)];
 [path addLineToPoint:CGPointMake(218.5, 40.5)];
 [path addLineToPoint:CGPointMake(202, 43.5)];
 [path addLineToPoint:CGPointMake(191, 60.5)];
 [path addLineToPoint:CGPointMake(189, 83.5)];
 [path addLineToPoint:CGPointMake(193, 96)];
 
 
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
 */
