//
//  main.c
//  CommandTool
//
//  Created by Alfred Hanssen on 11/17/13.
//  Copyright (c) 2013 Alfred Hanssen. All rights reserved.
//

#include <stdio.h>

struct Tree {
    int age;
    float height;
    float trunkDiameter;
    float canopyDiameter;
}; // Height and diameters expressed in meters, age in years

int main(int argc, const char * argv[])
{
    struct Tree tree;
    tree.age = 5;
    tree.height = 10.75f;
    tree.trunkDiameter = 0.5f;
    tree.canopyDiameter = 5.0f;
    
    printf("The tree is %.2f meters high and %i years old.\n", tree.height, tree.age);
    
    return 0;
}
