//
//  ViewController.m
//  openglTest
//
//  Created by linekong on 2018/5/16.
//  Copyright © 2018年 linekong. All rights reserved.
//

#import "ViewController.h"
#import <OpenGLES/ES3/glext.h>
@interface ViewController ()
{
    GLuint vao;
    GLuint vbo;
    GLuint imageTexture;
    NSInteger count;
}
@property (nonatomic, strong) EAGLContext *mContext;
@property (nonatomic, strong) GLKBaseEffect *mEffect;
@property (nonatomic, assign) GLuint myProgram;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    count = 0;
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    GLKView *kView = (GLKView *)self.view;
    kView.context = self.mContext;
    kView.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:self.mContext];
    
    [self linkProgram];
    
    float vertics[] = {
        0.5f, -0.5f, 0.5f,  0.0f, 0.0f, 0.000, 0.586, 1.000, 1.000,
        0.5f, 0.5f, 0.5f,  1.0f, 1.0f, 0.000, 0.586, 1.000, 1.000,
        -0.5f,  0.5f, 0.5f,  0.0f, 1.0f, 0.000, 0.586, 1.000, 1.000,
        -0.5f,  -0.5f, 0.5f,  1.0f, 0.0f, 0.000, 0.586, 1.000, 1.000,

        -0.5f, -0.5f,  -0.5f,  1.0f, 0.0f, 0.119, 0.519, 0.142, 1.000,
        -0.5f, 0.5f,  -0.5f,  0.0f, 1.0f, 0.119, 0.519, 0.142, 1.000,
        0.5f,  0.5f,  -0.5f,  1.0f, 1.0f, 0.119, 0.519, 0.142, 1.000,
        0.5f,  -0.5f,  -0.5f,  0.0f, 0.0f, 0.119, 0.519, 0.142, 1.000,

        -0.5f,  -0.5f,  0.5f,  0.0f, 1.0f, 1.000, 0.652, 0.000, 1.000,
        -0.5f,  0.5f, 0.5f,  1.0f, 1.0f, 1.000, 0.652, 0.000, 1.000,
        -0.5f, 0.5f, -0.5f,  0.0f, 0.0f, 1.000, 0.652, 0.000, 1.000,
        -0.5f, -0.5f, -0.5f,  1.0f, 0.0f, 1.000, 0.652, 0.000, 1.000,

        0.5f,  -0.5f,  -0.5f,  1.0f, 0.0f, 1.000, 0.000, 0.000, 1.000,
        0.5f,  0.5f, -0.5f, 0.0f, 0.0f, 1.000, 0.000, 0.000, 1.000,
        0.5f, 0.5f, 0.5f,  1.0f, 1.0f, 1.000, 0.000, 0.000, 1.000,
        0.5f, -0.5f, 0.5f,  0.0f, 1.0f, 1.000, 0.000, 0.000, 1.000,

        0.5f, 0.5f, 0.5f,  1.0f, 1.0f, 1.000, 1.000, 0.000, 1.000,
        0.5f, 0.5f, -0.5f,  0.0f, 0.0f, 1.000, 1.000, 0.000, 1.000,
        -0.5f, 0.5f,  -0.5f,  1.0f, 0.0f, 1.000, 1.000, 0.000, 1.000,
        -0.5f, 0.5f,  0.5f,  0.0f, 1.0f, 1.000, 1.000, 0.000, 1.000,

        0.5f,  -0.5f, -0.5f,  1.0f, 0.0f, 0.000, 0.000, 0.000, 1.000,
        0.5f,  -0.5f, 0.5f,  1.0f, 1.0f, 0.000, 0.000, 0.000, 1.000,
        -0.5f,  -0.5f,  0.5f,  0.0f, 1.0f, 0.000, 0.000, 0.000, 1.000,
        -0.5f,  -0.5f,  -0.5f,  1.0f, 0.0f, 0.000, 0.000, 0.000, 1.000,
    };

    unsigned int indices[] = {
        // Front
        0, 1, 2,
        2, 3, 0,
        // Right
        4, 5, 6,
        6, 7, 4,
        // Back
        8 , 9 , 10,
        10, 11, 8 ,
        // Left
        12, 13, 14,
        14, 15, 12,
        // Top
        16, 17, 18,
        18, 19, 16,
        // Bottom
        20, 21, 22,
        22, 23, 20,
    };
    
    glUseProgram(self.myProgram);
    
    GLuint veo;
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);
    glGenBuffers(1, &vbo);
    glGenBuffers(1, &veo);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertics), vertics, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, veo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    
    GLuint position = glGetAttribLocation(self.myProgram, "position");
    glVertexAttribPointer(position, 3, GL_FLOAT, GL_FALSE, 9*sizeof(float), (void*)0);
    glEnableVertexAttribArray(position);

    
    GLuint tetcoord = glGetAttribLocation(self.myProgram, "aTexCoord");
    glVertexAttribPointer(tetcoord, 2, GL_FLOAT, GL_FALSE, 9*sizeof(float), (void*)(3*sizeof(float)));
    glEnableVertexAttribArray(tetcoord);
    
    GLuint color = glGetAttribLocation(self.myProgram, "aColor");
    glVertexAttribPointer(color, 4, GL_FLOAT, GL_FALSE, 9*sizeof(float), (void*)(5*sizeof(float)));
    glEnableVertexAttribArray(color);
    
    
    GLuint texture = glGetUniformLocation(self.myProgram, "ourTexture");
    glUniform1i(texture, 0);
    
    GLuint transform = glGetUniformLocation(self.myProgram, "transform");
    GLKMatrix4 modelViewMatrix = GLKMatrix4Identity;
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(180), 0, 0, 1);
    glUniformMatrix4fv(transform, 1, GL_FALSE, modelViewMatrix.m);
    
    GLKMatrix4 viewMat = GLKMatrix4Identity;
    GLKMatrix4 projectioMat = GLKMatrix4Identity;
    viewMat = GLKMatrix4Translate(viewMat, 0, 0, -5);
    projectioMat = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(45.0), 1, 0.1, 100.0);
    
    GLuint viewGlt = glGetUniformLocation(self.myProgram, "viewMat");
    GLuint projectioGlt = glGetUniformLocation(self.myProgram, "projectionMat");
    glUniformMatrix4fv(viewGlt, 1, GL_FALSE, viewMat.m);
    glUniformMatrix4fv(projectioGlt, 1, GL_FALSE, projectioMat.m);
    
    imageTexture = [self setupTexture:@"wall.jpg"];
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glUseProgram(self.myProgram);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, imageTexture);
    count = (count + 1) % 360;
    GLKMatrix4 modelMat = GLKMatrix4Identity;
    modelMat = GLKMatrix4Rotate(modelMat, GLKMathDegreesToRadians(count), 0.5, 1.0, 0.0);
    GLuint modelGlt = glGetUniformLocation(self.myProgram, "modelMat");
    glUniformMatrix4fv(modelGlt, 1, GL_FALSE, modelMat.m);
    glBindVertexArray(vao);
    glDrawElements(GL_TRIANGLES, 36, GL_UNSIGNED_INT, 0);
    
}

#pragma mark - link

- (void)linkProgram {
    NSString *vertFile = [[NSBundle mainBundle] pathForResource:@"shaderv" ofType:@"vsh"];
    NSString *fragFile = [[NSBundle mainBundle] pathForResource:@"shaderf" ofType:@"fsh"];
    
//    NSString *vertContent = [NSString stringWithCString:kVertexShader encoding:NSUTF8StringEncoding];
//    NSString *fragContent = [NSString stringWithCString:kFragShader encoding:NSUTF8StringEncoding];
//
    self.myProgram = [self loadShaders:vertFile frag:fragFile];
    glLinkProgram(self.myProgram);
    GLint linkSuccess;
    
    glGetProgramiv(self.myProgram, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) { //连接错误
        GLchar messages[256];
        glGetProgramInfoLog(self.myProgram, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"error%@", messageString);
        return ;
    }
    else {
        NSLog(@"link ok");
        glUseProgram(self.myProgram); //成功便使用，避免由于未使用导致的的bug
    }
}

- (GLuint)loadShaders:(NSString *)vert frag:(NSString *)frag {
    GLuint verShader, fragShader;
    GLint program = glCreateProgram();
    
    [self compileShader:&verShader type:GL_VERTEX_SHADER file:vert];
    [self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:frag];
    
    glAttachShader(program, verShader);
    glAttachShader(program, fragShader);
    
    glDeleteShader(verShader);
    glDeleteShader(fragShader);
    
    return program;
}

- (void)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file {
    NSString *content = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    const GLchar *source = (GLchar *)[content UTF8String];
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
}

- (void)update {
    
}

#pragma mark -  image texture

- (GLuint)setupTexture:(NSString *)fileName {
    // 1获取图片的CGImageRef
    CGImageRef spriteImage = [UIImage imageNamed:fileName].CGImage;
    if (!spriteImage) {
        NSLog(@"Failed to load image %@", fileName);
        exit(1);
    }
    
    // 2 读取图片的大小
    size_t width = CGImageGetWidth(spriteImage);
    size_t height = CGImageGetHeight(spriteImage);
    
    GLubyte * spriteData = (GLubyte *) calloc(width * height * 4, sizeof(GLubyte)); //rgba共4个byte
    
    CGContextRef spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width*4,
                                                       CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
    
    // 3在CGContextRef上绘图
    CGContextDrawImage(spriteContext, CGRectMake(0, 0, width, height), spriteImage);
    
    CGContextRelease(spriteContext);
    
    // 4绑定纹理到默认的纹理ID（这里只有一张图片，故而相当于默认于片元着色器里面的colorMap，如果有多张图不可以这么做）
    GLuint texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    
    float fw = width, fh = height;
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, fw, fh, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
    
    glBindTexture(GL_TEXTURE_2D, 0);
    
    free(spriteData);
    return texture;
}

@end
