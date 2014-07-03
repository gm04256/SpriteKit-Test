//
//  BGMGeometry.h
//  SpriteKit Test
//
//  Created by 馬 岩 on 14-7-2.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#ifndef SpriteKit_Test_BGMGeometry_h
#define SpriteKit_Test_BGMGeometry_h

// Takes a CGVector and a CGFLoat.
// Returns a new CGFloat where each component of v has been multiplied by m.
static inline CGVector BGMVectorMultiply(CGVector v, CGFloat m) {
    return CGVectorMake(v.dx * m, v.dy * m);
}
// Takes two CGPoints.
// Returns a CGVector representing a direction from p1 to p2.
static inline CGVector BGMVectorBetweenPoints(CGPoint p1, CGPoint p2) {
    return CGVectorMake(p2.x - p1.x, p2.y - p1.y);
}
// Takes a CGVector.
// Returns a CGFloat containing the length of the vector, calculated using
// Pythagoras' theorem.
static inline CGFloat BGMVectorLength(CGVector v) {
    return sqrtf(powf(v.dx, 2) + powf(v.dy, 2));
}
// Takes two CGPoints. Returns a CGFloat containing the distance between them,
// calculated with Pythagoras' theorem.
static inline CGFloat BGMPointDistance(CGPoint p1, CGPoint p2) {
    return sqrtf(powf(p2.x - p1.x, 2) + powf(p2.y - p1.y, 2));
}

#endif
