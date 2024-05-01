#include "lib/shared/point.hlsl"
#include "lib/shared/quat-functions.hlsl"

cbuffer Params : register(b1)
{
    float3 Position;
    float __padding;
    float3 Size;
    float WrapMode;
}

StructuredBuffer<Point> SourcePoints : t0;        
RWStructuredBuffer<Point> ResultPoints : u0;   

[numthreads(64,1,1)]
void main(uint3 i : SV_DispatchThreadID)
{
    uint numStructs, stride;
    SourcePoints.GetDimensions(numStructs, stride);
    if(i.x >= numStructs) {
        return;
    }

    ResultPoints[i.x] =  SourcePoints[i.x];

    float3 a = (SourcePoints[i.x].Position - Position  + Size/2);
    float3 newPosition;
    
    switch( (int)WrapMode) {
        case 0: // Wrap
            newPosition  =  mod(a, Size) - Size/2 + Position;
            break;
        case 1: // Clamp
            newPosition  =  clamp(a, 0, Size) - Size/2 + Position;
            break;
        case 2: // Mirror
            newPosition  =  mod(a, Size * 2.0);
            newPosition = newPosition <= Size ? newPosition - Size/2 + Position : Size - newPosition + Size/2 + Position;
            break;
    }

    ResultPoints[i.x].Position = newPosition;
}

