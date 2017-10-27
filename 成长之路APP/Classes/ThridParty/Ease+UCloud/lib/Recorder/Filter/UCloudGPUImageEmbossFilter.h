#import "UCloudGPUImage3x3ConvolutionFilter.h"

@interface UCloudGPUImageEmbossFilter : UCloudGPUImage3x3ConvolutionFilter

// The strength of the embossing, from  0.0 to 4.0, with 1.0 as the normal level
@property(readwrite, nonatomic) CGFloat intensity; 

@end
