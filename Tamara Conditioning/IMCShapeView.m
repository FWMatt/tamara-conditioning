//
//  IMCShapeView.m
//  IBMCaptureUISDK
//
//  Created by Pedro Sebastião on 13/03/2017.
//  Copyright © 2017 IBM. All rights reserved.
//

#import "IMCShapeView.h"

@implementation IMCShapeView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (CAShapeLayer *)shapeLayer {
    return (CAShapeLayer *)self.layer;
}

@end
