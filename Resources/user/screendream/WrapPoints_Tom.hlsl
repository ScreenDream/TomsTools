#include "lib/shared/point.hlsl"
#include "lib/shared/quat-functions.hlsl"

cbuffer Params : register(b1)
{
    float3 Position;
    float FieldMode;
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

    float3 pos = SourcePoints[i.x].Position;
    float3 newPosition;

    if(FieldMode < 0.5)  // Box
    {
        float3 a = (pos - Position  + Size/2);
        switch((int)WrapMode) 
        {
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
    }
    else // Sphere
    {
        float3 pos2 = pos - Position;
        float dist = length(pos2);
        float rad = Size.x * 0.5;
        switch((int)WrapMode) 
        {
            case 0: // Wrap
                if(dist > rad) 
                {
                    newPosition = normalize(pos2) * (rad - Size.x + fmod(dist + rad, Size.x)) + Position;
                }
                else
                {
                    newPosition = pos;
                }
                break;
            case 1: // Clamp
                if(dist > rad) 
                {
                    newPosition = normalize(pos2) * rad + Position;
                }
                else
                {
                    newPosition = pos;
                }
                break;
            case 2: // Mirror
                if(dist > rad) 
                {
                    float temp = fmod(dist + rad, Size.x * 2);
                    temp = temp > Size.x ? Size.x - temp : temp - Size.x;
                    newPosition = normalize(pos2) * (rad + temp) + Position;                
                }
                else
                {
                    newPosition = pos;
                }
                break;
        }
    }
    


    ResultPoints[i.x].Position = newPosition;
}

