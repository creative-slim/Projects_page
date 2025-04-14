// Created with NodeToy | Three.js r149
// Updated for Three.js r175

// <node_builder>


// uniforms
uniform mat4 u_worldToObjectMatrix; uniform vec3 u_viewDirection; uniform float u_time; uniform sampler2D nodeUniform0; 
// attributes


// varys
varying vec3 nodeVary0; varying vec3 nodeVary1; varying vec2 nodeVary2; 
// vars
vec3 nodeVar0; vec3 nodeVar1; float nodeVar2; vec2 nodeVar3; float nodeVar4; float nodeVar5; vec2 nodeVar6; vec2 nodeVar7; vec2 nodeVar8; float nodeVar9; vec4 nodeVar10; float nodeVar11; float nodeVar12; vec2 nodeVar13; float nodeVar14; vec2 nodeVar15; vec2 nodeVar16; vec4 nodeVar17; vec4 nodeVar18; vec4 nodeVar19; vec4 nodeVar20; vec4 nodeVar21; vec4 nodeVar22; float nodeVar23; float nodeVar24; vec2 nodeVar25; float nodeVar26; vec4 nodeVar27; float nodeVar28; vec4 nodeVar29; vec4 nodeVar30; vec4 nodeVar31; vec4 nodeVar32; vec4 nodeVar33; vec4 nodeVar34; vec3 nodeVar35; 
// codes
float customFn_ZNRPnAsn6VSm (  ) {
                
    
    float NdotV = dot(nodeVar0, normalize(nodeVar1));
    float fresnelNode = ( vec3( 0.5, 3, 1.5 ).x + vec3( 0.5, 3, 1.5 ).y * pow( 1.0 - NdotV, vec3( 0.5, 3, 1.5 ).z) );
    return fresnelNode;
    
            }
vec4 customFn_2uRokZvecmTz ( float time ) {
                
    
    //    <3
    //       <3
    //    <3
    // <3


    // Gradient struct
    struct Gradient {
        vec4 colors[8];
        vec2 alphas[8];
        float colorsLength;
        float alphasLength;
        float type;
    };


    // Gradient  ~ - ~ - ~
    Gradient gradient;
    gradient.type = 1.0;
    gradient.colors = vec4[8](vec4(float(0.17254901960784313),float(0.2823529411764706),float(0.34901960784313724),float(0.705)),vec4(float(1),float(1),float(1),float(0.757)),vec4(float(1),float(1),float(1),float(1.000)),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0));
    gradient.alphas = vec2[8](vec2(float(1),float(1.000)),vec2(0.0,1.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0));
    gradient.colorsLength = float(3);
    gradient.alphasLength = float(1);


    vec3 color = gradient.colors[0].rgb;


    for (int c = 1; c < 8; c++)
    {
        float colorPos = clamp((time - gradient.colors[c-1].w) / (gradient.colors[c].w - gradient.colors[c-1].w), 0.0, 1.0) * step(float(c), gradient.colorsLength-1.0);
        color = mix(color, gradient.colors[c].rgb, mix(colorPos, step(0.01, colorPos), gradient.type));
    }
    


    float alpha = gradient.alphas[0].x;
    for (int a = 1; a < 8; a++)
    {
        float alphaPos = clamp((time - gradient.alphas[a-1].y) / (gradient.alphas[a].y - gradient.alphas[a-1].y), 0.0, 1.0) * step(float(a), gradient.alphasLength-1.0);
        alpha = mix(alpha, gradient.alphas[a].x, mix(alphaPos, step(0.01, alphaPos), gradient.type));
    }
    return vec4(color, alpha);
    
            }
vec2 voronoihash_plRPBBCUoJ9O ( vec2 p ) {


        p = vec2( dot( p, vec2( 127.1, 311.7 ) ), dot( p, vec2( 269.5, 183.3 ) ) );
        return fract( sin( p ) *43758.5453);
}




        float voronoi_plRPBBCUoJ9O( vec2 v, float time, inout vec2 id, inout vec2 mr, float smoothness ){
vec2 n = floor( v );
        vec2 f = fract( v );
        float F1 = 8.0;
        float F2 = 8.0; vec2 mg = vec2(0.0,0.0);
        for ( int j = -1; j <= 1; j++ )
        {
                for ( int i = -1; i <= 1; i++ )
                 {
                         vec2 g = vec2( i, j );
                         vec2 o = voronoihash_plRPBBCUoJ9O( n + g );
                o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); vec2 r = f - g - o;
                        float d = 0.707 * sqrt(dot( r, r ));
                         if( d<F1 ) {
                                 F2 = F1;
                                 F1 = d; mg = g; mr = r; id = o;
                         } else if( d<F2 ) {
                                 F2 = d;
                         }
                 }
        }
        return F2 - F1;}
float customFn_cFnlRYi2pQL5 ( vec2 uv, float angle, float scale, float smoothness,inout vec2 id,inout vec2 uv1 ) {
                
        
        //         VORONOI        //
        // <3 ~ <3 ~ <3 ~ <3 ~ <3 //
    
        vec2 coords = uv * scale;
        
        id = vec2(0.0, 0.0);
        uv1 = vec2(0.0, 0.0);
        float voroi = voronoi_plRPBBCUoJ9O(coords, angle, id, uv1, float(0.0));
        return voroi;
    
        
            }
vec4 customFn_MTmovrkvsCm5 ( float time ) {
                
    
    //    <3
    //       <3
    //    <3
    // <3


    // Gradient struct
    struct Gradient {
        vec4 colors[8];
        vec2 alphas[8];
        float colorsLength;
        float alphasLength;
        float type;
    };


    // Gradient  ~ - ~ - ~
    Gradient gradient;
    gradient.type = 0.0;
    gradient.colors = vec4[8](vec4(float(0.6470588235294118),float(0),float(0.9725490196078431),float(0.000)),vec4(float(0),float(0.9215686274509803),float(1),float(1.000)),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0));
    gradient.alphas = vec2[8](vec2(float(1),float(1.000)),vec2(0.0,1.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0));
    gradient.colorsLength = float(2);
    gradient.alphasLength = float(1);


    vec3 color = gradient.colors[0].rgb;


    for (int c = 1; c < 8; c++)
    {
        float colorPos = clamp((time - gradient.colors[c-1].w) / (gradient.colors[c].w - gradient.colors[c-1].w), 0.0, 1.0) * step(float(c), gradient.colorsLength-1.0);
        color = mix(color, gradient.colors[c].rgb, mix(colorPos, step(0.01, colorPos), gradient.type));
    }
    


    float alpha = gradient.alphas[0].x;
    for (int a = 1; a < 8; a++)
    {
        float alphaPos = clamp((time - gradient.alphas[a-1].y) / (gradient.alphas[a].y - gradient.alphas[a-1].y), 0.0, 1.0) * step(float(a), gradient.alphasLength-1.0);
        alpha = mix(alpha, gradient.alphas[a].x, mix(alphaPos, step(0.01, alphaPos), gradient.type));
    }
    return vec4(color, alpha);
    
            }
vec2 customFn_PuOQRLGBkl6g ( vec2 uv, vec2 anchor, float time ) {
    // Modern GLSL prefers explicit variable types and initialization
    float cosVar = cos(time);
    float sinVar = sin(time);
    return (( uv - anchor) * mat2(cosVar, -sinVar, sinVar, cosVar)) + anchor;
}
vec3 mod2D289_npFsoj8rim2g ( vec3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }


        vec2 mod2D289_npFsoj8rim2g( vec2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }


        vec3 permute_npFsoj8rim2g( vec3 x ) { return mod2D289_npFsoj8rim2g( ( ( x * 34.0 ) + 1.0 ) * x ); }


    float snoise_npFsoj8rim2g( vec2 v ){
        const vec4 C = vec4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
        vec2 i = floor( v + dot( v, C.yy ) );
        vec2 x0 = v - i + dot( i, C.xx );
        vec2 i1;
        i1 = ( x0.x > x0.y ) ? vec2( 1.0, 0.0 ) : vec2( 0.0, 1.0 );
        vec4 x12 = x0.xyxy + C.xxzz;
        x12.xy -= i1;
        i = mod2D289_npFsoj8rim2g( i );
        vec3 p = permute_npFsoj8rim2g( permute_npFsoj8rim2g( i.y + vec3( 0.0, i1.y, 1.0 ) ) + i.x + vec3( 0.0, i1.x, 1.0 ) );
        vec3 m = max( 0.5 - vec3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
        m = m * m;
        m = m * m;
        vec3 x = 2.0 * fract( p * C.www ) - 1.0;
        vec3 h = abs( x ) - 0.5;
        vec3 ox = floor( x + 0.5 );
        vec3 a0 = x - ox;
        m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
        vec3 g;
        g.x = a0.x * x0.x + h.x * x0.y;
        g.yz = a0.yz * x12.xz + h.yz * x12.yw;
        return 130.0 * dot( m, g );
    }
float customFn_HnMwzeEVmWOL ( vec2 uv, float scale ) {
                
    float noise = snoise_npFsoj8rim2g( uv * scale );
    
    noise = noise*0.5 + 0.5;
    return noise;
    
            
            }
vec4 customFn_roVdygqiukxY ( float time ) {
                
    
    //    <3
    //       <3
    //    <3
    // <3


    // Gradient struct
    struct Gradient {
        vec4 colors[8];
        vec2 alphas[8];
        float colorsLength;
        float alphasLength;
        float type;
    };


    // Gradient  ~ - ~ - ~
    Gradient gradient;
    gradient.type = 0.0;
    gradient.colors = vec4[8](vec4(float(0.27450980392156865),float(0.9764705882352941),float(1),float(0.325)),vec4(float(1),float(0),float(0.807843137254902),float(0.708)),vec4(float(0),float(0.1843137254901961),float(1),float(1.000)),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0));
    gradient.alphas = vec2[8](vec2(float(1),float(1.000)),vec2(0.0,1.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0));
    gradient.colorsLength = float(3);
    gradient.alphasLength = float(1);


    vec3 color = gradient.colors[0].rgb;


    for (int c = 1; c < 8; c++)
    {
        float colorPos = clamp((time - gradient.colors[c-1].w) / (gradient.colors[c].w - gradient.colors[c-1].w), 0.0, 1.0) * step(float(c), gradient.colorsLength-1.0);
        color = mix(color, gradient.colors[c].rgb, mix(colorPos, step(0.01, colorPos), gradient.type));
    }
    


    float alpha = gradient.alphas[0].x;
    for (int a = 1; a < 8; a++)
    {
        float alphaPos = clamp((time - gradient.alphas[a-1].y) / (gradient.alphas[a].y - gradient.alphas[a-1].y), 0.0, 1.0) * step(float(a), gradient.alphasLength-1.0);
        alpha = mix(alpha, gradient.alphas[a].x, mix(alphaPos, step(0.01, alphaPos), gradient.type));
    }
    return vec4(color, alpha);
    
            }
vec4 customFn_0ZhZ8Fk4N4y5 ( float time ) {
                
    
    //    <3
    //       <3
    //    <3
    // <3


    // Gradient struct
    struct Gradient {
        vec4 colors[8];
        vec2 alphas[8];
        float colorsLength;
        float alphasLength;
        float type;
    };


    // Gradient  ~ - ~ - ~
    Gradient gradient;
    gradient.type = 0.0;
    gradient.colors = vec4[8](vec4(float(0.1411764705882353),float(0.24705882352941178),float(0.24313725490196078),float(0.000)),vec4(float(0),float(0.40784313725490196),float(0.592156862745098),float(0.200)),vec4(float(0.24313725490196078),float(0.24313725490196078),float(0.7176470588235294),float(0.465)),vec4(float(0.6470588235294118),float(0.18823529411764706),float(0.7843137254901961),float(0.793)),vec4(float(0.3176470588235294),float(0.11764705882352941),float(0.396078431372549),float(1.000)),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0));
    gradient.alphas = vec2[8](vec2(float(1),float(1.000)),vec2(0.0,1.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0));
    gradient.colorsLength = float(5);
    gradient.alphasLength = float(1);


    vec3 color = gradient.colors[0].rgb;


    for (int c = 1; c < 8; c++)
    {
        float colorPos = clamp((time - gradient.colors[c-1].w) / (gradient.colors[c].w - gradient.colors[c-1].w), 0.0, 1.0) * step(float(c), gradient.colorsLength-1.0);
        color = mix(color, gradient.colors[c].rgb, mix(colorPos, step(0.01, colorPos), gradient.type));
    }
    


    float alpha = gradient.alphas[0].x;
    for (int a = 1; a < 8; a++)
    {
        float alphaPos = clamp((time - gradient.alphas[a-1].y) / (gradient.alphas[a].y - gradient.alphas[a-1].y), 0.0, 1.0) * step(float(a), gradient.alphasLength-1.0);
        alpha = mix(alpha, gradient.alphas[a].x, mix(alphaPos, step(0.01, alphaPos), gradient.type));
    }
    return vec4(color, alpha);
    
            }
float remap_GgCvAhPMvp0X ( float value, float minOld, float maxOld, float minNew, float maxNew ) {
                float x = ( value - minOld ) / ( maxOld - minOld );
                return minNew + ( maxNew - minNew ) * x;
        }
vec4 customFn_p6S3ehdL7EI5 ( vec4 value, vec4 minOld, vec4 maxOld, vec4 minNew, vec4 maxNew ) {
                
    return vec4(
        remap_GgCvAhPMvp0X( value.x, minOld.x, maxOld.x, minNew.x, maxNew.x ),
        remap_GgCvAhPMvp0X( value.y, minOld.y, maxOld.y, minNew.y, maxNew.y ),
        remap_GgCvAhPMvp0X( value.z, minOld.z, maxOld.z, minNew.z, maxNew.z ),
        remap_GgCvAhPMvp0X( value.w, minOld.w, maxOld.w, minNew.w, maxNew.w )
    );
            
            }
vec4 customFn_9ljrgZ7GAWwS ( float time ) {
                
    
    //    <3
    //       <3
    //    <3
    // <3


    // Gradient struct
    struct Gradient {
        vec4 colors[8];
        vec2 alphas[8];
        float colorsLength;
        float alphasLength;
        float type;
    };


    // Gradient  ~ - ~ - ~
    Gradient gradient;
    gradient.type = 0.0;
    gradient.colors = vec4[8](vec4(float(0.5843137254901961),float(0.5843137254901961),float(0.5843137254901961),float(0.000)),vec4(float(0),float(0),float(0),float(0.510)),vec4(float(0.12156862745098039),float(0.11764705882352941),float(0.12156862745098039),float(0.791)),vec4(float(0.1803921568627451),float(0.1803921568627451),float(0.1803921568627451),float(0.888)),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0));
    gradient.alphas = vec2[8](vec2(float(1),float(0)),vec2(float(1),float(1)),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0));
    gradient.colorsLength = float(4);
    gradient.alphasLength = float(2);


    vec3 color = gradient.colors[0].rgb;


    for (int c = 1; c < 8; c++)
    {
        float colorPos = clamp((time - gradient.colors[c-1].w) / (gradient.colors[c].w - gradient.colors[c-1].w), 0.0, 1.0) * step(float(c), gradient.colorsLength-1.0);
        color = mix(color, gradient.colors[c].rgb, mix(colorPos, step(0.01, colorPos), gradient.type));
    }
    


    float alpha = gradient.alphas[0].x;
    for (int a = 1; a < 8; a++)
    {
        float alphaPos = clamp((time - gradient.alphas[a-1].y) / (gradient.alphas[a].y - gradient.alphas[a-1].y), 0.0, 1.0) * step(float(a), gradient.alphasLength-1.0);
        alpha = mix(alpha, gradient.alphas[a].x, mix(alphaPos, step(0.01, alphaPos), gradient.type));
    }
    return vec4(color, alpha);
    
            }
vec3 mod2D289_I9suCfJGHhze ( vec3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }


        vec2 mod2D289_I9suCfJGHhze( vec2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }


        vec3 permute_I9suCfJGHhze( vec3 x ) { return mod2D289_I9suCfJGHhze( ( ( x * 34.0 ) + 1.0 ) * x ); }


    float snoise_I9suCfJGHhze( vec2 v ){
        const vec4 C = vec4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
        vec2 i = floor( v + dot( v, C.yy ) );
        vec2 x0 = v - i + dot( i, C.xx );
        vec2 i1;
        i1 = ( x0.x > x0.y ) ? vec2( 1.0, 0.0 ) : vec2( 0.0, 1.0 );
        vec4 x12 = x0.xyxy + C.xxzz;
        x12.xy -= i1;
        i = mod2D289_I9suCfJGHhze( i );
        vec3 p = permute_I9suCfJGHhze( permute_I9suCfJGHhze( i.y + vec3( 0.0, i1.y, 1.0 ) ) + i.x + vec3( 0.0, i1.x, 1.0 ) );
        vec3 m = max( 0.5 - vec3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
        m = m * m;
        m = m * m;
        vec3 x = 2.0 * fract( p * C.www ) - 1.0;
        vec3 h = abs( x ) - 0.5;
        vec3 ox = floor( x + 0.5 );
        vec3 a0 = x - ox;
        m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
        vec3 g;
        g.x = a0.x * x0.x + h.x * x0.y;
        g.yz = a0.yz * x12.xz + h.yz * x12.yw;
        return 130.0 * dot( m, g );
    }
float customFn_FYOsVQx113n6 ( vec2 uv, float scale ) {
                
    float noise = snoise_I9suCfJGHhze( uv * scale );
    
    noise = noise*0.5 + 0.5;
    return noise;
    
            
            }
vec4 customFn_Qvy092QDMXHT ( float time ) {
                
    
    //    <3
    //       <3
    //    <3
    // <3


    // Gradient struct
    struct Gradient {
        vec4 colors[8];
        vec2 alphas[8];
        float colorsLength;
        float alphasLength;
        float type;
    };


    // Gradient  ~ - ~ - ~
    Gradient gradient;
    gradient.type = 0.0;
    gradient.colors = vec4[8](vec4(float(0.2823529411764706),float(0.2823529411764706),float(0.2823529411764706),float(0.499)),vec4(float(0.5098039215686274),float(0.5098039215686274),float(0.5098039215686274),float(1.000)),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0),vec4(0.0,0.0,0.0,0.0));
    gradient.alphas = vec2[8](vec2(float(1),float(0.197)),vec2(0.0,1.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0),vec2(0.0,0.0));
    gradient.colorsLength = float(2);
    gradient.alphasLength = float(1);


    vec3 color = gradient.colors[0].rgb;


    for (int c = 1; c < 8; c++)
    {
        float colorPos = clamp((time - gradient.colors[c-1].w) / (gradient.colors[c].w - gradient.colors[c-1].w), 0.0, 1.0) * step(float(c), gradient.colorsLength-1.0);
        color = mix(color, gradient.colors[c].rgb, mix(colorPos, step(0.01, colorPos), gradient.type));
    }
    


    float alpha = gradient.alphas[0].x;
    for (int a = 1; a < 8; a++)
    {
        float alphaPos = clamp((time - gradient.alphas[a-1].y) / (gradient.alphas[a].y - gradient.alphas[a-1].y), 0.0, 1.0) * step(float(a), gradient.alphasLength-1.0);
        alpha = mix(alpha, gradient.alphas[a].x, mix(alphaPos, step(0.01, alphaPos), gradient.type));
    }
    return vec4(color, alpha);
    
            }
vec3 mod2D289_GQvriXQxnoLU ( vec3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }


        vec2 mod2D289_GQvriXQxnoLU( vec2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }


        vec3 permute_GQvriXQxnoLU( vec3 x ) { return mod2D289_GQvriXQxnoLU( ( ( x * 34.0 ) + 1.0 ) * x ); }


    float snoise_GQvriXQxnoLU( vec2 v ){
        const vec4 C = vec4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
        vec2 i = floor( v + dot( v, C.yy ) );
        vec2 x0 = v - i + dot( i, C.xx );
        vec2 i1;
        i1 = ( x0.x > x0.y ) ? vec2( 1.0, 0.0 ) : vec2( 0.0, 1.0 );
        vec4 x12 = x0.xyxy + C.xxzz;
        x12.xy -= i1;
        i = mod2D289_GQvriXQxnoLU( i );
        vec3 p = permute_GQvriXQxnoLU( permute_GQvriXQxnoLU( i.y + vec3( 0.0, i1.y, 1.0 ) ) + i.x + vec3( 0.0, i1.x, 1.0 ) );
        vec3 m = max( 0.5 - vec3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
        m = m * m;
        m = m * m;
        vec3 x = 2.0 * fract( p * C.www ) - 1.0;
        vec3 h = abs( x ) - 0.5;
        vec3 ox = floor( x + 0.5 );
        vec3 a0 = x - ox;
        m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
        vec3 g;
        g.x = a0.x * x0.x + h.x * x0.y;
        g.yz = a0.yz * x12.xz + h.yz * x12.yw;
        return 130.0 * dot( m, g );
    }
float customFn_c61HDgpPM9fI ( vec2 uv, float scale ) {
                
    float noise = snoise_GQvriXQxnoLU( uv * scale );
    
    noise = noise*0.5 + 0.5;
    return noise;
    
            
            }


// variables
// </node_builder>














#define STANDARD


#ifdef PHYSICAL
        #define IOR
        #define SPECULAR
#endif


#ifdef IOR
        float ior;
#endif


#ifdef SPECULAR
        uniform float specularIntensity;
        uniform vec3 specularColor;


        #ifdef USE_SPECULARINTENSITYMAP
                uniform sampler2D specularIntensityMap;
        #endif


        #ifdef USE_SPECULARCOLORMAP
                uniform sampler2D specularColorMap;
        #endif
#endif


#ifdef USE_CLEARCOAT
        float clearcoat;
        float clearcoatRoughness;
#endif


#ifdef USE_IRIDESCENCE
        float iridescence;
        float iridescenceIOR;
        uniform float iridescenceThicknessMinimum;
        float iridescenceThicknessMaximum;
#endif


#ifdef USE_SHEEN
        uniform vec3 sheenColor;
        uniform float sheenRoughness;


        #ifdef USE_SHEENCOLORMAP
                uniform sampler2D sheenColorMap;
        #endif


        #ifdef USE_SHEENROUGHNESSMAP
                uniform sampler2D sheenRoughnessMap;
        #endif
#endif


varying vec3 vViewPosition;




#define PI 3.141592653589793
#define PI2 6.283185307179586
#define PI_HALF 1.5707963267948966
#define RECIPROCAL_PI 0.3183098861837907
#define RECIPROCAL_PI2 0.15915494309189535
#define EPSILON 1e-6


#ifndef saturate
// <tonemapping_pars_fragment> may have defined saturate() already
#define saturate( a ) clamp( a, 0.0, 1.0 )
#endif
#define whiteComplement( a ) ( 1.0 - saturate( a ) )


float pow2( const in float x ) { return x*x; }
vec3 pow2( const in vec3 x ) { return x*x; }
float pow3( const in float x ) { return x*x*x; }
float pow4( const in float x ) { float x2 = x*x; return x2*x2; }
float max3( const in vec3 v ) { return max( max( v.x, v.y ), v.z ); }
float average( const in vec3 v ) { return dot( v, vec3( 0.3333333 ) ); }


// expects values in the range of [0,1]x[0,1], returns values in the [0,1] range.
// do not collapse into a single function per: http://byteblacksmith.com/improvements-to-the-canonical-one-liner-glsl-rand-for-opengl-es-2-0/
highp float rand( const in vec2 uv ) {


        const highp float a = 12.9898, b = 78.233, c = 43758.5453;
        highp float dt = dot( uv.xy, vec2( a,b ) ), sn = mod( dt, PI );


        return fract( sin( sn ) * c );


}


#ifdef HIGH_PRECISION
        float precisionSafeLength( vec3 v ) { return length( v ); }
#else
        float precisionSafeLength( vec3 v ) {
                float maxComponent = max3( abs( v ) );
                return length( v / maxComponent ) * maxComponent;
        }
#endif


struct IncidentLight {
        vec3 color;
        vec3 direction;
        bool visible;
};


struct ReflectedLight {
        vec3 directDiffuse;
        vec3 directSpecular;
        vec3 indirectDiffuse;
        vec3 indirectSpecular;
};


struct GeometricContext {
        vec3 position;
        vec3 normal;
        vec3 viewDir;
#ifdef USE_CLEARCOAT
        vec3 clearcoatNormal;
#endif
};


vec3 transformDirection( in vec3 dir, in mat4 matrix ) {


        return normalize( ( matrix * vec4( dir, 0.0 ) ).xyz );


}


vec3 inverseTransformDirection( in vec3 dir, in mat4 matrix ) {


        // dir can be either a direction vector or a normal vector
        // upper-left 3x3 of matrix is assumed to be orthogonal


        return normalize( ( vec4( dir, 0.0 ) * matrix ).xyz );


}


mat3 transposeMat3( const in mat3 m ) {


        mat3 tmp;


        tmp[ 0 ] = vec3( m[ 0 ].x, m[ 1 ].x, m[ 2 ].x );
        tmp[ 1 ] = vec3( m[ 0 ].y, m[ 1 ].y, m[ 2 ].y );
        tmp[ 2 ] = vec3( m[ 0 ].z, m[ 1 ].z, m[ 2 ].z );


        return tmp;


}


float luminance( const in vec3 rgb ) {


        // assumes rgb is in linear color space with sRGB primaries and D65 white point


        const vec3 weights = vec3( 0.2126729, 0.7151522, 0.0721750 );


        return dot( weights, rgb );


}


bool isPerspectiveMatrix( mat4 m ) {


        return m[ 2 ][ 3 ] == - 1.0;


}


vec2 equirectUv( in vec3 dir ) {


        // dir is assumed to be unit length


        float u = atan( dir.z, dir.x ) * RECIPROCAL_PI2 + 0.5;


        float v = asin( clamp( dir.y, - 1.0, 1.0 ) ) * RECIPROCAL_PI + 0.5;


        return vec2( u, v );


}




vec3 packNormalToRGB( const in vec3 normal ) {
        return normalize( normal ) * 0.5 + 0.5;
}


vec3 unpackRGBToNormal( const in vec3 rgb ) {
        return 2.0 * rgb.xyz - 1.0;
}


const float PackUpscale = 256. / 255.; // fraction -> 0..1 (including 1)
const float UnpackDownscale = 255. / 256.; // 0..1 -> fraction (excluding 1)


const vec3 PackFactors = vec3( 256. * 256. * 256., 256. * 256., 256. );
const vec4 UnpackFactors = UnpackDownscale / vec4( PackFactors, 1. );


const float ShiftRight8 = 1. / 256.;


vec4 packDepthToRGBA( const in float v ) {
        vec4 r = vec4( fract( v * PackFactors ), v );
        r.yzw -= r.xyz * ShiftRight8; // tidy overflow
        return r * PackUpscale;
}


float unpackRGBAToDepth( const in vec4 v ) {
        return dot( v, UnpackFactors );
}


vec2 packDepthToRG( in highp float v ) {
        return packDepthToRGBA( v ).yx;
}


float unpackRGToDepth( const in highp vec2 v ) {
        return unpackRGBAToDepth( vec4( v.xy, 0.0, 0.0 ) );
}


vec4 pack2HalfToRGBA( vec2 v ) {
        vec4 r = vec4( v.x, fract( v.x * 255.0 ), v.y, fract( v.y * 255.0 ) );
        return vec4( r.x - r.y / 255.0, r.y, r.z - r.w / 255.0, r.w );
}


vec2 unpackRGBATo2Half( vec4 v ) {
        return vec2( v.x + ( v.y / 255.0 ), v.z + ( v.w / 255.0 ) );
}


// NOTE: viewZ/eyeZ is < 0 when in front of the camera per OpenGL conventions


float viewZToOrthographicDepth( const in float viewZ, const in float near, const in float far ) {
        return ( viewZ + near ) / ( near - far );
}
float orthographicDepthToViewZ( const in float linearClipZ, const in float near, const in float far ) {
        return linearClipZ * ( near - far ) - near;
}


// NOTE: https://twitter.com/gonnavis/status/1377183786949959682


float viewZToPerspectiveDepth( const in float viewZ, const in float near, const in float far ) {
        return ( ( near + viewZ ) * far ) / ( ( far - near ) * viewZ );
}
float perspectiveDepthToViewZ( const in float invClipZ, const in float near, const in float far ) {
        return ( near * far ) / ( ( far - near ) * invClipZ - far );
}




#ifdef DITHERING


        // based on https://www.shadertoy.com/view/MslGR8
        vec3 dithering( vec3 color ) {
                //Calculate grid position
                float grid_position = rand( gl_FragCoord.xy );


                //Shift the individual colors differently, thus making it even harder to see the dithering pattern
                vec3 dither_shift_RGB = vec3( 0.25 / 255.0, -0.25 / 255.0, 0.25 / 255.0 );


                //modify shift according to grid position.
                dither_shift_RGB = mix( 2.0 * dither_shift_RGB, -2.0 * dither_shift_RGB, grid_position );


                //shift the color by dither_shift
                return color + dither_shift_RGB;
        }


#endif




#if defined( USE_COLOR_ALPHA )


        varying vec4 vColor;


#elif defined( USE_COLOR )


        varying vec3 vColor;


#endif




#if ( defined( USE_UV ) && ! defined( UVS_VERTEX_ONLY ) )


        varying vec2 vUv;


#endif




#if defined( USE_LIGHTMAP ) || defined( USE_AOMAP )


        varying vec2 vUv2;


#endif




#ifdef USE_MAP


        uniform sampler2D map;


#endif




#ifdef USE_ALPHAMAP


        uniform sampler2D alphaMap;


#endif




#ifdef USE_ALPHATEST
        uniform float alphaTest;
#endif




#ifdef USE_AOMAP


        uniform sampler2D aoMap;
        uniform float aoMapIntensity;


#endif




#ifdef USE_LIGHTMAP


        uniform sampler2D lightMap;
        uniform float lightMapIntensity;


#endif




#ifdef USE_EMISSIVEMAP


        uniform sampler2D emissiveMap;


#endif






vec3 BRDF_Lambert( const in vec3 diffuseColor ) {


        return RECIPROCAL_PI * diffuseColor;


} // validated


vec3 F_Schlick( const in vec3 f0, const in float f90, const in float dotVH ) {


        // Original approximation by Christophe Schlick '94
        // float fresnel = pow( 1.0 - dotVH, 5.0 );


        // Optimized variant (presented by Epic at SIGGRAPH '13)
        // https://cdn2.unrealengine.com/Resources/files/2013SiggraphPresentationsNotes-26915738.pdf
        float fresnel = exp2( ( - 5.55473 * dotVH - 6.98316 ) * dotVH );


        return f0 * ( 1.0 - fresnel ) + ( f90 * fresnel );


} // validated


float F_Schlick( const in float f0, const in float f90, const in float dotVH ) {


        // Original approximation by Christophe Schlick '94
        // float fresnel = pow( 1.0 - dotVH, 5.0 );


        // Optimized variant (presented by Epic at SIGGRAPH '13)
        // https://cdn2.unrealengine.com/Resources/files/2013SiggraphPresentationsNotes-26915738.pdf
        float fresnel = exp2( ( - 5.55473 * dotVH - 6.98316 ) * dotVH );


        return f0 * ( 1.0 - fresnel ) + ( f90 * fresnel );


} // validated


vec3 Schlick_to_F0( const in vec3 f, const in float f90, const in float dotVH ) {
    float x = clamp( 1.0 - dotVH, 0.0, 1.0 );
    float x2 = x * x;
    float x5 = clamp( x * x2 * x2, 0.0, 0.9999 );


    return ( f - vec3( f90 ) * x5 ) / ( 1.0 - x5 );
}


// Moving Frostbite to Physically Based Rendering 3.0 - page 12, listing 2
// https://seblagarde.files.wordpress.com/2015/07/course_notes_moving_frostbite_to_pbr_v32.pdf
float V_GGX_SmithCorrelated( const in float alpha, const in float dotNL, const in float dotNV ) {


        float a2 = pow2( alpha );


        float gv = dotNL * sqrt( a2 + ( 1.0 - a2 ) * pow2( dotNV ) );
        float gl = dotNV * sqrt( a2 + ( 1.0 - a2 ) * pow2( dotNL ) );


        return 0.5 / max( gv + gl, EPSILON );


}


// Microfacet Models for Refraction through Rough Surfaces - equation (33)
// http://graphicrants.blogspot.com/2013/08/specular-brdf-reference.html
// alpha is "roughness squared" in Disney’s reparameterization
float D_GGX( const in float alpha, const in float dotNH ) {


        float a2 = pow2( alpha );


        float denom = pow2( dotNH ) * ( a2 - 1.0 ) + 1.0; // avoid alpha = 0 with dotNH = 1


        return RECIPROCAL_PI * a2 / pow2( denom );


}


// GGX Distribution, Schlick Fresnel, GGX_SmithCorrelated Visibility
vec3 BRDF_GGX( const in vec3 lightDir, const in vec3 viewDir, const in vec3 normal, const in vec3 f0, const in float f90, const in float roughness ) {


        float alpha = pow2( roughness ); // UE4's roughness


        vec3 halfDir = normalize( lightDir + viewDir );


        float dotNL = saturate( dot( normal, lightDir ) );
        float dotNV = saturate( dot( normal, viewDir ) );
        float dotNH = saturate( dot( normal, halfDir ) );
        float dotVH = saturate( dot( viewDir, halfDir ) );


        vec3 F = F_Schlick( f0, f90, dotVH );


        float V = V_GGX_SmithCorrelated( alpha, dotNL, dotNV );


        float D = D_GGX( alpha, dotNH );


        return F * ( V * D );


}


#ifdef USE_IRIDESCENCE


        vec3 BRDF_GGX_Iridescence( const in vec3 lightDir, const in vec3 viewDir, const in vec3 normal, const in vec3 f0, const in float f90, const in float iridescence, const in vec3 iridescenceFresnel, const in float roughness ) {


                float alpha = pow2( roughness ); // UE4's roughness


                vec3 halfDir = normalize( lightDir + viewDir );


                float dotNL = saturate( dot( normal, lightDir ) );
                float dotNV = saturate( dot( normal, viewDir ) );
                float dotNH = saturate( dot( normal, halfDir ) );
                float dotVH = saturate( dot( viewDir, halfDir ) );


                vec3 F = mix( F_Schlick( f0, f90, dotVH ), iridescenceFresnel, iridescence );


                float V = V_GGX_SmithCorrelated( alpha, dotNL, dotNV );


                float D = D_GGX( alpha, dotNH );


                return F * ( V * D );


        }


#endif


// Rect Area Light


// Real-Time Polygonal-Light Shading with Linearly Transformed Cosines
// by Eric Heitz, Jonathan Dupuy, Stephen Hill and David Neubelt
// code: https://github.com/selfshadow/ltc_code/


vec2 LTC_Uv( const in vec3 N, const in vec3 V, const in float roughness ) {


        const float LUT_SIZE = 64.0;
        const float LUT_SCALE = ( LUT_SIZE - 1.0 ) / LUT_SIZE;
        const float LUT_BIAS = 0.5 / LUT_SIZE;


        float dotNV = saturate( dot( N, V ) );


        // texture parameterized by sqrt( GGX alpha ) and sqrt( 1 - cos( theta ) )
        vec2 uv = vec2( roughness, sqrt( 1.0 - dotNV ) );


        uv = uv * LUT_SCALE + LUT_BIAS;


        return uv;


}


float LTC_ClippedSphereFormFactor( const in vec3 f ) {


        // Real-Time Area Lighting: a Journey from Research to Production (p.102)
        // An approximation of the form factor of a horizon-clipped rectangle.


        float l = length( f );


        return max( ( l * l + f.z ) / ( l + 1.0 ), 0.0 );


}


vec3 LTC_EdgeVectorFormFactor( const in vec3 v1, const in vec3 v2 ) {


        float x = dot( v1, v2 );


        float y = abs( x );


        // rational polynomial approximation to theta / sin( theta ) / 2PI
        float a = 0.8543985 + ( 0.4965155 + 0.0145206 * y ) * y;
        float b = 3.4175940 + ( 4.1616724 + y ) * y;
        float v = a / b;


        float theta_sintheta = ( x > 0.0 ) ? v : 0.5 * inversesqrt( max( 1.0 - x * x, 1e-7 ) ) - v;


        return cross( v1, v2 ) * theta_sintheta;


}


vec3 LTC_Evaluate( const in vec3 N, const in vec3 V, const in vec3 P, const in mat3 mInv, const in vec3 rectCoords[ 4 ] ) {


        // bail if point is on back side of plane of light
        // assumes ccw winding order of light vertices
        vec3 v1 = rectCoords[ 1 ] - rectCoords[ 0 ];
        vec3 v2 = rectCoords[ 3 ] - rectCoords[ 0 ];
        vec3 lightNormal = cross( v1, v2 );


        if( dot( lightNormal, P - rectCoords[ 0 ] ) < 0.0 ) return vec3( 0.0 );


        // construct orthonormal basis around N
        vec3 T1, T2;
        T1 = normalize( V - N * dot( V, N ) );
        T2 = - cross( N, T1 ); // negated from paper; possibly due to a different handedness of world coordinate system


        // compute transform
        mat3 mat = mInv * transposeMat3( mat3( T1, T2, N ) );


        // transform rect
        vec3 coords[ 4 ];
        coords[ 0 ] = mat * ( rectCoords[ 0 ] - P );
        coords[ 1 ] = mat * ( rectCoords[ 1 ] - P );
        coords[ 2 ] = mat * ( rectCoords[ 2 ] - P );
        coords[ 3 ] = mat * ( rectCoords[ 3 ] - P );


        // project rect onto sphere
        coords[ 0 ] = normalize( coords[ 0 ] );
        coords[ 1 ] = normalize( coords[ 1 ] );
        coords[ 2 ] = normalize( coords[ 2 ] );
        coords[ 3 ] = normalize( coords[ 3 ] );


        // calculate vector form factor
        vec3 vectorFormFactor = vec3( 0.0 );
        vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 0 ], coords[ 1 ] );
        vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 1 ], coords[ 2 ] );
        vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 2 ], coords[ 3 ] );
        vectorFormFactor += LTC_EdgeVectorFormFactor( coords[ 3 ], coords[ 0 ] );


        // adjust for horizon clipping
        float result = LTC_ClippedSphereFormFactor( vectorFormFactor );


/*
        // alternate method of adjusting for horizon clipping (see referece)
        // refactoring required
        float len = length( vectorFormFactor );
        float z = vectorFormFactor.z / len;


        const float LUT_SIZE = 64.0;
        const float LUT_SCALE = ( LUT_SIZE - 1.0 ) / LUT_SIZE;
        const float LUT_BIAS = 0.5 / LUT_SIZE;


        // tabulated horizon-clipped sphere, apparently...
        vec2 uv = vec2( z * 0.5 + 0.5, len );
        uv = uv * LUT_SCALE + LUT_BIAS;


        float scale = texture( ltc_2, uv ).w;


        float result = len * scale;
*/


        return vec3( result );


}


// End Rect Area Light




float G_BlinnPhong_Implicit( /* const in float dotNL, const in float dotNV */ ) {


        // geometry term is (n dot l)(n dot v) / 4(n dot l)(n dot v)
        return 0.25;


}


float D_BlinnPhong( const in float shininess, const in float dotNH ) {


        return RECIPROCAL_PI * ( shininess * 0.5 + 1.0 ) * pow( dotNH, shininess );


}


vec3 BRDF_BlinnPhong( const in vec3 lightDir, const in vec3 viewDir, const in vec3 normal, const in vec3 specularColor, const in float shininess ) {


        vec3 halfDir = normalize( lightDir + viewDir );


        float dotNH = saturate( dot( normal, halfDir ) );
        float dotVH = saturate( dot( viewDir, halfDir ) );


        vec3 F = F_Schlick( specularColor, 1.0, dotVH );


        float G = G_BlinnPhong_Implicit( /* dotNL, dotNV */ );


        float D = D_BlinnPhong( shininess, dotNH );


        return F * ( G * D );


} // validated


#if defined( USE_SHEEN )


// https://github.com/google/filament/blob/master/shaders/src/brdf.fs
float D_Charlie( float roughness, float dotNH ) {


        float alpha = pow2( roughness );


        // Estevez and Kulla 2017, "Production Friendly Microfacet Sheen BRDF"
        float invAlpha = 1.0 / alpha;
        float cos2h = dotNH * dotNH;
        float sin2h = max( 1.0 - cos2h, 0.0078125 ); // 2^(-14/2), so sin2h^2 > 0 in fp16


        return ( 2.0 + invAlpha ) * pow( sin2h, invAlpha * 0.5 ) / ( 2.0 * PI );


}


// https://github.com/google/filament/blob/master/shaders/src/brdf.fs
float V_Neubelt( float dotNV, float dotNL ) {


        // Neubelt and Pettineo 2013, "Crafting a Next-gen Material Pipeline for The Order: 1886"
        return saturate( 1.0 / ( 4.0 * ( dotNL + dotNV - dotNL * dotNV ) ) );


}


vec3 BRDF_Sheen( const in vec3 lightDir, const in vec3 viewDir, const in vec3 normal, vec3 sheenColor, const in float sheenRoughness ) {


        vec3 halfDir = normalize( lightDir + viewDir );


        float dotNL = saturate( dot( normal, lightDir ) );
        float dotNV = saturate( dot( normal, viewDir ) );
        float dotNH = saturate( dot( normal, halfDir ) );


        float D = D_Charlie( sheenRoughness, dotNH );
        float V = V_Neubelt( dotNV, dotNL );


        return sheenColor * ( D * V );


}


#endif






#ifdef USE_IRIDESCENCE


        // XYZ to linear-sRGB color space
        const mat3 XYZ_TO_REC709 = mat3(
                 3.2404542, -0.9692660,  0.0556434,
                -1.5371385,  1.8760108, -0.2040259,
                -0.4985314,  0.0415560,  1.0572252
        );


        // Assume air interface for top
        // Note: We don't handle the case fresnel0 == 1
        vec3 Fresnel0ToIor( vec3 fresnel0 ) {


                vec3 sqrtF0 = sqrt( fresnel0 );
                return ( vec3( 1.0 ) + sqrtF0 ) / ( vec3( 1.0 ) - sqrtF0 );


        }


        // Conversion FO/IOR
        vec3 IorToFresnel0( vec3 transmittedIor, float incidentIor ) {


                return pow2( ( transmittedIor - vec3( incidentIor ) ) / ( transmittedIor + vec3( incidentIor ) ) );


        }


        // ior is a value between 1.0 and 3.0. 1.0 is air interface
        float IorToFresnel0( float transmittedIor, float incidentIor ) {


                return pow2( ( transmittedIor - incidentIor ) / ( transmittedIor + incidentIor ));


        }


        // Fresnel equations for dielectric/dielectric interfaces.
        // Ref: https://belcour.github.io/blog/research/2017/05/01/brdf-thin-film.html
        // Evaluation XYZ sensitivity curves in Fourier space
        vec3 evalSensitivity( float OPD, vec3 shift ) {


                float phase = 2.0 * PI * OPD * 1.0e-9;
                vec3 val = vec3( 5.4856e-13, 4.4201e-13, 5.2481e-13 );
                vec3 pos = vec3( 1.6810e+06, 1.7953e+06, 2.2084e+06 );
                vec3 var = vec3( 4.3278e+09, 9.3046e+09, 6.6121e+09 );


                vec3 xyz = val * sqrt( 2.0 * PI * var ) * cos( pos * phase + shift ) * exp( - pow2( phase ) * var );
                xyz.x += 9.7470e-14 * sqrt( 2.0 * PI * 4.5282e+09 ) * cos( 2.2399e+06 * phase + shift[ 0 ] ) * exp( - 4.5282e+09 * pow2( phase ) );
                xyz /= 1.0685e-7;


                vec3 rgb = XYZ_TO_REC709 * xyz;
                return rgb;


        }


        vec3 evalIridescence( float outsideIOR, float eta2, float cosTheta1, float thinFilmThickness, vec3 baseF0 ) {


                vec3 I;


                // Force iridescenceIOR -> outsideIOR when thinFilmThickness -> 0.0
                float iridescenceIOR = mix( outsideIOR, eta2, smoothstep( 0.0, 0.03, thinFilmThickness ) );
                // Evaluate the cosTheta on the base layer (Snell law)
                float sinTheta2Sq = pow2( outsideIOR / iridescenceIOR ) * ( 1.0 - pow2( cosTheta1 ) );


                // Handle TIR:
                float cosTheta2Sq = 1.0 - sinTheta2Sq;
                if ( cosTheta2Sq < 0.0 ) {


                         return vec3( 1.0 );


                }


                float cosTheta2 = sqrt( cosTheta2Sq );


                // First interface
                float R0 = IorToFresnel0( iridescenceIOR, outsideIOR );
                float R12 = F_Schlick( R0, 1.0, cosTheta1 );
                float R21 = R12;
                float T121 = 1.0 - R12;
                float phi12 = 0.0;
                if ( iridescenceIOR < outsideIOR ) phi12 = PI;
                float phi21 = PI - phi12;


                // Second interface
                vec3 baseIOR = Fresnel0ToIor( clamp( baseF0, 0.0, 0.9999 ) ); // guard against 1.0
                vec3 R1 = IorToFresnel0( baseIOR, iridescenceIOR );
                vec3 R23 = F_Schlick( R1, 1.0, cosTheta2 );
                vec3 phi23 = vec3( 0.0 );
                if ( baseIOR[ 0 ] < iridescenceIOR ) phi23[ 0 ] = PI;
                if ( baseIOR[ 1 ] < iridescenceIOR ) phi23[ 1 ] = PI;
                if ( baseIOR[ 2 ] < iridescenceIOR ) phi23[ 2 ] = PI;


                // Phase shift
                float OPD = 2.0 * iridescenceIOR * thinFilmThickness * cosTheta2;
                vec3 phi = vec3( phi21 ) + phi23;


                // Compound terms
                vec3 R123 = clamp( R12 * R23, 1e-5, 0.9999 );
                vec3 r123 = sqrt( R123 );
                vec3 Rs = pow2( T121 ) * R23 / ( vec3( 1.0 ) - R123 );


                // Reflectance term for m = 0 (DC term amplitude)
                vec3 C0 = R12 + Rs;
                I = C0;


                // Reflectance term for m > 0 (pairs of diracs)
                vec3 Cm = Rs - T121;
                for ( int m = 1; m <= 2; ++ m ) {


                        Cm *= r123;
                        vec3 Sm = 2.0 * evalSensitivity( float( m ) * OPD, float( m ) * phi );
                        I += Cm * Sm;


                }


                // Since out of gamut colors might be produced, negative color values are clamped to 0.
                return max( I, vec3( 0.0 ) );


        }


#endif






#ifdef ENVMAP_TYPE_CUBE_UV


        #define cubeUV_minMipLevel 4.0
        #define cubeUV_minTileSize 16.0


        // These shader functions convert between the UV coordinates of a single face of
        // a cubemap, the 0-5 integer index of a cube face, and the direction vector for
        // sampling a textureCube (not generally normalized ).


        float getFace( vec3 direction ) {


                vec3 absDirection = abs( direction );


                float face = - 1.0;


                if ( absDirection.x > absDirection.z ) {


                        if ( absDirection.x > absDirection.y )


                                face = direction.x > 0.0 ? 0.0 : 3.0;


                        else


                                face = direction.y > 0.0 ? 1.0 : 4.0;


                } else {


                        if ( absDirection.z > absDirection.y )


                                face = direction.z > 0.0 ? 2.0 : 5.0;


                        else


                                face = direction.y > 0.0 ? 1.0 : 4.0;


                }


                return face;


        }


        // RH coordinate system; PMREM face-indexing convention
        vec2 getUV( vec3 direction, float face ) {


                vec2 uv;


                if ( face == 0.0 ) {


                        uv = vec2( direction.z, direction.y ) / abs( direction.x ); // pos x


                } else if ( face == 1.0 ) {


                        uv = vec2( - direction.x, - direction.z ) / abs( direction.y ); // pos y


                } else if ( face == 2.0 ) {


                        uv = vec2( - direction.x, direction.y ) / abs( direction.z ); // pos z


                } else if ( face == 3.0 ) {


                        uv = vec2( - direction.z, direction.y ) / abs( direction.x ); // neg x


                } else if ( face == 4.0 ) {


                        uv = vec2( - direction.x, direction.z ) / abs( direction.y ); // neg y


                } else {


                        uv = vec2( direction.x, direction.y ) / abs( direction.z ); // neg z


                }


                return 0.5 * ( uv + 1.0 );


        }


        vec3 bilinearCubeUV( sampler2D envMap, vec3 direction, float mipInt ) {


                float face = getFace( direction );


                float filterInt = max( cubeUV_minMipLevel - mipInt, 0.0 );


                mipInt = max( mipInt, cubeUV_minMipLevel );


                float faceSize = exp2( mipInt );


                highp vec2 uv = getUV( direction, face ) * ( faceSize - 2.0 ) + 1.0; // #25071


                if ( face > 2.0 ) {


                        uv.y += faceSize;


                        face -= 3.0;


                }


                uv.x += face * faceSize;


                uv.x += filterInt * 3.0 * cubeUV_minTileSize;


                uv.y += 4.0 * ( exp2( CUBEUV_MAX_MIP ) - faceSize );


                uv.x *= CUBEUV_TEXEL_WIDTH;
                uv.y *= CUBEUV_TEXEL_HEIGHT;


                #ifdef texture2DGradEXT


                        return texture2DGradEXT( envMap, uv, vec2( 0.0 ), vec2( 0.0 ) ).rgb; // disable anisotropic filtering


                #else


                        return texture( envMap, uv ).rgb;


                #endif


        }


        // These defines must match with PMREMGenerator


        #define cubeUV_r0 1.0
        #define cubeUV_v0 0.339
        #define cubeUV_m0 - 2.0
        #define cubeUV_r1 0.8
        #define cubeUV_v1 0.276
        #define cubeUV_m1 - 1.0
        #define cubeUV_r4 0.4
        #define cubeUV_v4 0.046
        #define cubeUV_m4 2.0
        #define cubeUV_r5 0.305
        #define cubeUV_v5 0.016
        #define cubeUV_m5 3.0
        #define cubeUV_r6 0.21
        #define cubeUV_v6 0.0038
        #define cubeUV_m6 4.0


        float roughnessToMip( float roughness ) {


                float mip = 0.0;


                if ( roughness >= cubeUV_r1 ) {


                        mip = ( cubeUV_r0 - roughness ) * ( cubeUV_m1 - cubeUV_m0 ) / ( cubeUV_r0 - cubeUV_r1 ) + cubeUV_m0;


                } else if ( roughness >= cubeUV_r4 ) {


                        mip = ( cubeUV_r1 - roughness ) * ( cubeUV_m4 - cubeUV_m1 ) / ( cubeUV_r1 - cubeUV_r4 ) + cubeUV_m1;


                } else if ( roughness >= cubeUV_r5 ) {


                        mip = ( cubeUV_r4 - roughness ) * ( cubeUV_m5 - cubeUV_m4 ) / ( cubeUV_r4 - cubeUV_r5 ) + cubeUV_m4;


                } else if ( roughness >= cubeUV_r6 ) {


                        mip = ( cubeUV_r5 - roughness ) * ( cubeUV_m6 - cubeUV_m5 ) / ( cubeUV_r5 - cubeUV_r6 ) + cubeUV_m5;


                } else {


                        mip = - 2.0 * log2( 1.16 * roughness ); // 1.16 = 1.79^0.25
                }


                return mip;


        }


        vec4 textureCubeUV( sampler2D envMap, vec3 sampleDir, float roughness ) {


                float mip = clamp( roughnessToMip( roughness ), cubeUV_m0, CUBEUV_MAX_MIP );


                float mipF = fract( mip );


                float mipInt = floor( mip );


                vec3 color0 = bilinearCubeUV( envMap, sampleDir, mipInt );


                if ( mipF == 0.0 ) {


                        return vec4( color0, 1.0 );


                } else {


                        vec3 color1 = bilinearCubeUV( envMap, sampleDir, mipInt + 1.0 );


                        return vec4( mix( color0, color1, mipF ), 1.0 );


                }


        }


#endif




#ifdef USE_ENVMAP


        uniform float envMapIntensity;
        uniform float flipEnvMap;


        #ifdef ENVMAP_TYPE_CUBE
                uniform samplerCube envMap;
        #else
                uniform sampler2D envMap;
        #endif
        
#endif




#if defined( USE_ENVMAP )


        vec3 getIBLIrradiance( const in vec3 normal ) {


                #if defined( ENVMAP_TYPE_CUBE_UV )


                        vec3 worldNormal = inverseTransformDirection( normal, viewMatrix );


                        vec4 envMapColor = textureCubeUV( envMap, worldNormal, 1.0 );


                        return PI * envMapColor.rgb * envMapIntensity;


                #else


                        return vec3( 0.0 );


                #endif


        }


        vec3 getIBLRadiance( const in vec3 viewDir, const in vec3 normal, const in float roughness ) {


                #if defined( ENVMAP_TYPE_CUBE_UV )


                        vec3 reflectVec = reflect( - viewDir, normal );


                        // Mixing the reflection with the normal is more accurate and keeps rough objects from gathering light from behind their tangent plane.
                        reflectVec = normalize( mix( reflectVec, normal, roughness * roughness) );


                        reflectVec = inverseTransformDirection( reflectVec, viewMatrix );


                        vec4 envMapColor = textureCubeUV( envMap, reflectVec, roughness );


                        return envMapColor.rgb * envMapIntensity;


                #else


                        return vec3( 0.0 );


                #endif


        }


#endif




#ifdef USE_FOG


        uniform vec3 fogColor;
        varying float vFogDepth;


        #ifdef FOG_EXP2


                uniform float fogDensity;


        #else


                uniform float fogNear;
                uniform float fogFar;


        #endif


#endif




uniform bool receiveShadow;
uniform vec3 ambientLightColor;
uniform vec3 lightProbe[ 9 ];


// get the irradiance (radiance convolved with cosine lobe) at the point 'normal' on the unit sphere
// source: https://graphics.stanford.edu/papers/envmap/envmap.pdf
vec3 shGetIrradianceAt( in vec3 normal, in vec3 shCoefficients[ 9 ] ) {


        // normal is assumed to have unit length


        float x = normal.x, y = normal.y, z = normal.z;


        // band 0
        vec3 result = shCoefficients[ 0 ] * 0.886227;


        // band 1
        result += shCoefficients[ 1 ] * 2.0 * 0.511664 * y;
        result += shCoefficients[ 2 ] * 2.0 * 0.511664 * z;
        result += shCoefficients[ 3 ] * 2.0 * 0.511664 * x;


        // band 2
        result += shCoefficients[ 4 ] * 2.0 * 0.429043 * x * y;
        result += shCoefficients[ 5 ] * 2.0 * 0.429043 * y * z;
        result += shCoefficients[ 6 ] * ( 0.743125 * z * z - 0.247708 );
        result += shCoefficients[ 7 ] * 2.0 * 0.429043 * x * z;
        result += shCoefficients[ 8 ] * 0.429043 * ( x * x - y * y );


        return result;


}


vec3 getLightProbeIrradiance( const in vec3 lightProbe[ 9 ], const in vec3 normal ) {


        vec3 worldNormal = inverseTransformDirection( normal, viewMatrix );


        vec3 irradiance = shGetIrradianceAt( worldNormal, lightProbe );


        return irradiance;


}


vec3 getAmbientLightIrradiance( const in vec3 ambientLightColor ) {


        vec3 irradiance = ambientLightColor;


        return irradiance;


}


float getDistanceAttenuation( const in float lightDistance, const in float cutoffDistance, const in float decayExponent ) {


        #if defined ( PHYSICALLY_CORRECT_LIGHTS )


                // based upon Frostbite 3 Moving to Physically-based Rendering
                // page 32, equation 26: E[window1]
                // https://seblagarde.files.wordpress.com/2015/07/course_notes_moving_frostbite_to_pbr_v32.pdf
                float distanceFalloff = 1.0 / max( pow( lightDistance, decayExponent ), 0.01 );


                if ( cutoffDistance > 0.0 ) {


                        distanceFalloff *= pow2( saturate( 1.0 - pow4( lightDistance / cutoffDistance ) ) );


                }


                return distanceFalloff;


        #else


                if ( cutoffDistance > 0.0 && decayExponent > 0.0 ) {


                        return pow( saturate( - lightDistance / cutoffDistance + 1.0 ), decayExponent );


                }


                return 1.0;


        #endif


}


float getSpotAttenuation( const in float coneCosine, const in float penumbraCosine, const in float angleCosine ) {


        return smoothstep( coneCosine, penumbraCosine, angleCosine );


}


#if NUM_DIR_LIGHTS > 0


        struct DirectionalLight {
                vec3 direction;
                vec3 color;
        };


        uniform DirectionalLight directionalLights[ NUM_DIR_LIGHTS ];


        void getDirectionalLightInfo( const in DirectionalLight directionalLight, const in GeometricContext geometry, out IncidentLight light ) {


                light.color = directionalLight.color;
                light.direction = directionalLight.direction;
                light.visible = true;


        }


#endif




#if NUM_POINT_LIGHTS > 0


        struct PointLight {
                vec3 position;
                vec3 color;
                float distance;
                float decay;
        };


        uniform PointLight pointLights[ NUM_POINT_LIGHTS ];


        // light is an out parameter as having it as a return value caused compiler errors on some devices
        void getPointLightInfo( const in PointLight pointLight, const in GeometricContext geometry, out IncidentLight light ) {


                vec3 lVector = pointLight.position - geometry.position;


                light.direction = normalize( lVector );


                float lightDistance = length( lVector );


                light.color = pointLight.color;
                light.color *= getDistanceAttenuation( lightDistance, pointLight.distance, pointLight.decay );
                light.visible = ( light.color != vec3( 0.0 ) );


        }


#endif




#if NUM_SPOT_LIGHTS > 0


        struct SpotLight {
                vec3 position;
                vec3 direction;
                vec3 color;
                float distance;
                float decay;
                float coneCos;
                float penumbraCos;
        };


        uniform SpotLight spotLights[ NUM_SPOT_LIGHTS ];


        // light is an out parameter as having it as a return value caused compiler errors on some devices
        void getSpotLightInfo( const in SpotLight spotLight, const in GeometricContext geometry, out IncidentLight light ) {


                vec3 lVector = spotLight.position - geometry.position;


                light.direction = normalize( lVector );


                float angleCos = dot( light.direction, spotLight.direction );


                float spotAttenuation = getSpotAttenuation( spotLight.coneCos, spotLight.penumbraCos, angleCos );


                if ( spotAttenuation > 0.0 ) {


                        float lightDistance = length( lVector );


                        light.color = spotLight.color * spotAttenuation;
                        light.color *= getDistanceAttenuation( lightDistance, spotLight.distance, spotLight.decay );
                        light.visible = ( light.color != vec3( 0.0 ) );


                } else {


                        light.color = vec3( 0.0 );
                        light.visible = false;


                }


        }


#endif




#if NUM_RECT_AREA_LIGHTS > 0


        struct RectAreaLight {
                vec3 color;
                vec3 position;
                vec3 halfWidth;
                vec3 halfHeight;
        };


        // Pre-computed values of LinearTransformedCosine approximation of BRDF
        // BRDF approximation Texture is 64x64
        uniform sampler2D ltc_1; // RGBA Float
        uniform sampler2D ltc_2; // RGBA Float


        uniform RectAreaLight rectAreaLights[ NUM_RECT_AREA_LIGHTS ];


#endif




#if NUM_HEMI_LIGHTS > 0


        struct HemisphereLight {
                vec3 direction;
                vec3 skyColor;
                vec3 groundColor;
        };


        uniform HemisphereLight hemisphereLights[ NUM_HEMI_LIGHTS ];


        vec3 getHemisphereLightIrradiance( const in HemisphereLight hemiLight, const in vec3 normal ) {


                float dotNL = dot( normal, hemiLight.direction );
                float hemiDiffuseWeight = 0.5 * dotNL + 0.5;


                vec3 irradiance = mix( hemiLight.groundColor, hemiLight.skyColor, hemiDiffuseWeight );


                return irradiance;


        }


#endif




#ifndef FLAT_SHADED


        varying vec3 vNormal;


        #ifdef USE_TANGENT


                varying vec3 vTangent;
                varying vec3 vBitangent;


        #endif


#endif




struct PhysicalMaterial {


        vec3 diffuseColor;
        float roughness;
        vec3 specularColor;
        float specularF90;


        #ifdef USE_CLEARCOAT
                float clearcoat;
                float clearcoatRoughness;
                vec3 clearcoatF0;
                float clearcoatF90;
        #endif


        #ifdef USE_IRIDESCENCE
                float iridescence;
                float iridescenceIOR;
                float iridescenceThickness;
                vec3 iridescenceFresnel;
                vec3 iridescenceF0;
        #endif


        #ifdef USE_SHEEN
                vec3 sheenColor;
                float sheenRoughness;
        #endif


        #ifdef IOR
                float ior;
        #endif


        #ifdef USE_TRANSMISSION
                float transmission;
                float transmissionAlpha;
                float thickness;
                float attenuationDistance;
                vec3 attenuationColor;
        #endif


};


// temporary
vec3 clearcoatSpecular = vec3( 0.0 );
vec3 sheenSpecular = vec3( 0.0 );


// This is a curve-fit approxmation to the "Charlie sheen" BRDF integrated over the hemisphere from 
// Estevez and Kulla 2017, "Production Friendly Microfacet Sheen BRDF". The analysis can be found
// in the Sheen section of https://drive.google.com/file/d/1T0D1VSyR4AllqIJTQAraEIzjlb5h4FKH/view?usp=sharing
float IBLSheenBRDF( const in vec3 normal, const in vec3 viewDir, const in float roughness ) {


        float dotNV = saturate( dot( normal, viewDir ) );


        float r2 = roughness * roughness;


        float a = roughness < 0.25 ? -339.2 * r2 + 161.4 * roughness - 25.9 : -8.48 * r2 + 14.3 * roughness - 9.95;


        float b = roughness < 0.25 ? 44.0 * r2 - 23.7 * roughness + 3.26 : 1.97 * r2 - 3.27 * roughness + 0.72;


        float DG = exp( a * dotNV + b ) + ( roughness < 0.25 ? 0.0 : 0.1 * ( roughness - 0.25 ) );


        return saturate( DG * RECIPROCAL_PI );


}


// Analytical approximation of the DFG LUT, one half of the
// split-sum approximation used in indirect specular lighting.
// via 'environmentBRDF' from "Physically Based Shading on Mobile"
// https://www.unrealengine.com/blog/physically-based-shading-on-mobile
vec2 DFGApprox( const in vec3 normal, const in vec3 viewDir, const in float roughness ) {


        float dotNV = saturate( dot( normal, viewDir ) );


        const vec4 c0 = vec4( - 1, - 0.0275, - 0.572, 0.022 );


        const vec4 c1 = vec4( 1, 0.0425, 1.04, - 0.04 );


        vec4 r = roughness * c0 + c1;


        float a004 = min( r.x * r.x, exp2( - 9.28 * dotNV ) ) * r.x + r.y;


        vec2 fab = vec2( - 1.04, 1.04 ) * a004 + r.zw;


        return fab;


}


vec3 EnvironmentBRDF( const in vec3 normal, const in vec3 viewDir, const in vec3 specularColor, const in float specularF90, const in float roughness ) {


        vec2 fab = DFGApprox( normal, viewDir, roughness );


        return specularColor * fab.x + specularF90 * fab.y;


}


// Fdez-Agüera's "Multiple-Scattering Microfacet Model for Real-Time Image Based Lighting"
// Approximates multiscattering in order to preserve energy.
// http://www.jcgt.org/published/0008/01/03/
#ifdef USE_IRIDESCENCE
void computeMultiscatteringIridescence( const in vec3 normal, const in vec3 viewDir, const in vec3 specularColor, const in float specularF90, const in float iridescence, const in vec3 iridescenceF0, const in float roughness, inout vec3 singleScatter, inout vec3 multiScatter ) {
#else
void computeMultiscattering( const in vec3 normal, const in vec3 viewDir, const in vec3 specularColor, const in float specularF90, const in float roughness, inout vec3 singleScatter, inout vec3 multiScatter ) {
#endif


        vec2 fab = DFGApprox( normal, viewDir, roughness );


        #ifdef USE_IRIDESCENCE


                vec3 Fr = mix( specularColor, iridescenceF0, iridescence );


        #else


                vec3 Fr = specularColor;


        #endif


        vec3 FssEss = Fr * fab.x + specularF90 * fab.y;


        float Ess = fab.x + fab.y;
        float Ems = 1.0 - Ess;


        vec3 Favg = Fr + ( 1.0 - Fr ) * 0.047619; // 1/21
        vec3 Fms = FssEss * Favg / ( 1.0 - Ems * Favg );


        singleScatter += FssEss;
        multiScatter += Fms * Ems;


}


#if NUM_RECT_AREA_LIGHTS > 0


        void RE_Direct_RectArea_Physical( const in RectAreaLight rectAreaLight, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {


                vec3 normal = geometry.normal;
                vec3 viewDir = geometry.viewDir;
                vec3 position = geometry.position;
                vec3 lightPos = rectAreaLight.position;
                vec3 halfWidth = rectAreaLight.halfWidth;
                vec3 halfHeight = rectAreaLight.halfHeight;
                vec3 lightColor = rectAreaLight.color;
                float roughness = material.roughness;


                vec3 rectCoords[ 4 ];
                rectCoords[ 0 ] = lightPos + halfWidth - halfHeight; // counterclockwise; light shines in local neg z direction
                rectCoords[ 1 ] = lightPos - halfWidth - halfHeight;
                rectCoords[ 2 ] = lightPos - halfWidth + halfHeight;
                rectCoords[ 3 ] = lightPos + halfWidth + halfHeight;


                vec2 uv = LTC_Uv( normal, viewDir, roughness );


                vec4 t1 = texture( ltc_1, uv );
                vec4 t2 = texture( ltc_2, uv );


                mat3 mInv = mat3(
                        vec3( t1.x, 0, t1.y ),
                        vec3(    0, 1,    0 ),
                        vec3( t1.z, 0, t1.w )
                );


                // LTC Fresnel Approximation by Stephen Hill
                // http://blog.selfshadow.com/publications/s2016-advances/s2016_ltc_fresnel.pdf
                vec3 fresnel = ( material.specularColor * t2.x + ( vec3( 1.0 ) - material.specularColor ) * t2.y );


                reflectedLight.directSpecular += lightColor * fresnel * LTC_Evaluate( normal, viewDir, position, mInv, rectCoords );


                reflectedLight.directDiffuse += lightColor * material.diffuseColor * LTC_Evaluate( normal, viewDir, position, mat3( 1.0 ), rectCoords );


        }


#endif


void RE_Direct_Physical( const in IncidentLight directLight, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {


        float dotNL = saturate( dot( geometry.normal, directLight.direction ) );


        vec3 irradiance = dotNL * directLight.color;


        #ifdef USE_CLEARCOAT


                float dotNLcc = saturate( dot( geometry.clearcoatNormal, directLight.direction ) );


                vec3 ccIrradiance = dotNLcc * directLight.color;


                clearcoatSpecular += ccIrradiance * BRDF_GGX( directLight.direction, geometry.viewDir, geometry.clearcoatNormal, material.clearcoatF0, material.clearcoatF90, material.clearcoatRoughness );


        #endif


        #ifdef USE_SHEEN


                sheenSpecular += irradiance * BRDF_Sheen( directLight.direction, geometry.viewDir, geometry.normal, material.sheenColor, material.sheenRoughness );


        #endif


        #ifdef USE_IRIDESCENCE


                reflectedLight.directSpecular += irradiance * BRDF_GGX_Iridescence( directLight.direction, geometry.viewDir, geometry.normal, material.specularColor, material.specularF90, material.iridescence, material.iridescenceFresnel, material.roughness );


        #else


                reflectedLight.directSpecular += irradiance * BRDF_GGX( directLight.direction, geometry.viewDir, geometry.normal, material.specularColor, material.specularF90, material.roughness );


        #endif


        reflectedLight.directDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );
}


void RE_IndirectDiffuse_Physical( const in vec3 irradiance, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight ) {


        reflectedLight.indirectDiffuse += irradiance * BRDF_Lambert( material.diffuseColor );


}


void RE_IndirectSpecular_Physical( const in vec3 radiance, const in vec3 irradiance, const in vec3 clearcoatRadiance, const in GeometricContext geometry, const in PhysicalMaterial material, inout ReflectedLight reflectedLight) {


        #ifdef USE_CLEARCOAT


                clearcoatSpecular += clearcoatRadiance * EnvironmentBRDF( geometry.clearcoatNormal, geometry.viewDir, material.clearcoatF0, material.clearcoatF90, material.clearcoatRoughness );


        #endif


        #ifdef USE_SHEEN


                sheenSpecular += irradiance * material.sheenColor * IBLSheenBRDF( geometry.normal, geometry.viewDir, material.sheenRoughness );


        #endif


        // Both indirect specular and indirect diffuse light accumulate here


        vec3 singleScattering = vec3( 0.0 );
        vec3 multiScattering = vec3( 0.0 );
        vec3 cosineWeightedIrradiance = irradiance * RECIPROCAL_PI;


        #ifdef USE_IRIDESCENCE


                computeMultiscatteringIridescence( geometry.normal, geometry.viewDir, material.specularColor, material.specularF90, material.iridescence, material.iridescenceFresnel, material.roughness, singleScattering, multiScattering );


        #else


                computeMultiscattering( geometry.normal, geometry.viewDir, material.specularColor, material.specularF90, material.roughness, singleScattering, multiScattering );


        #endif


        vec3 totalScattering = singleScattering + multiScattering;
        vec3 diffuse = material.diffuseColor * ( 1.0 - max( max( totalScattering.r, totalScattering.g ), totalScattering.b ) );


        reflectedLight.indirectSpecular += radiance * singleScattering;
        reflectedLight.indirectSpecular += multiScattering * cosineWeightedIrradiance;


        reflectedLight.indirectDiffuse += diffuse * cosineWeightedIrradiance;


}


#define RE_Direct                                RE_Direct_Physical
#define RE_Direct_RectArea                RE_Direct_RectArea_Physical
#define RE_IndirectDiffuse                RE_IndirectDiffuse_Physical
#define RE_IndirectSpecular                RE_IndirectSpecular_Physical


// ref: https://seblagarde.files.wordpress.com/2015/07/course_notes_moving_frostbite_to_pbr_v32.pdf
float computeSpecularOcclusion( const in float dotNV, const in float ambientOcclusion, const in float roughness ) {


        return saturate( pow( dotNV + ambientOcclusion, exp2( - 16.0 * roughness - 1.0 ) ) - 1.0 + ambientOcclusion );


}




#ifdef USE_TRANSMISSION


        // Transmission code is based on glTF-Sampler-Viewer
        // https://github.com/KhronosGroup/glTF-Sample-Viewer


        float transmission;
        uniform float thickness;
        uniform float attenuationDistance;
        uniform vec3 attenuationColor;


        #ifdef USE_TRANSMISSIONMAP


                uniform sampler2D transmissionMap;


        #endif


        #ifdef USE_THICKNESSMAP


                uniform sampler2D thicknessMap;


        #endif


        uniform vec2 transmissionSamplerSize;
        uniform sampler2D transmissionSamplerMap;


        uniform mat4 modelMatrix;
        uniform mat4 projectionMatrix;


        varying vec3 vWorldPosition;


        vec3 getVolumeTransmissionRay( const in vec3 n, const in vec3 v, const in float thickness, const in float ior, const in mat4 modelMatrix ) {


                // Direction of refracted light.
                vec3 refractionVector = refract( - v, normalize( n ), 1.0 / ior );


                // Compute rotation-independant scaling of the model matrix.
                vec3 modelScale;
                modelScale.x = length( vec3( modelMatrix[ 0 ].xyz ) );
                modelScale.y = length( vec3( modelMatrix[ 1 ].xyz ) );
                modelScale.z = length( vec3( modelMatrix[ 2 ].xyz ) );


                // The thickness is specified in local space.
                return normalize( refractionVector ) * thickness * modelScale;


        }


        float applyIorToRoughness( const in float roughness, const in float ior ) {


                // Scale roughness with IOR so that an IOR of 1.0 results in no microfacet refraction and
                // an IOR of 1.5 results in the default amount of microfacet refraction.
                return roughness * clamp( ior * 2.0 - 2.0, 0.0, 1.0 );


        }


        vec4 getTransmissionSample( const in vec2 fragCoord, const in float roughness, const in float ior ) {


                float framebufferLod = log2( transmissionSamplerSize.x ) * applyIorToRoughness( roughness, ior );


                #ifdef texture2DLodEXT


                        return texture2DLodEXT( transmissionSamplerMap, fragCoord.xy, framebufferLod );


                #else


                        return textureLod( transmissionSamplerMap, fragCoord.xy, framebufferLod );


                #endif


        }


        vec3 applyVolumeAttenuation( const in vec3 radiance, const in float transmissionDistance, const in vec3 attenuationColor, const in float attenuationDistance ) {


                if ( isinf( attenuationDistance ) ) {


                        // Attenuation distance is +∞, i.e. the transmitted color is not attenuated at all.
                        return radiance;


                } else {


                        // Compute light attenuation using Beer's law.
                        vec3 attenuationCoefficient = -log( attenuationColor ) / attenuationDistance;
                        vec3 transmittance = exp( - attenuationCoefficient * transmissionDistance ); // Beer's law
                        return transmittance * radiance;


                }


        }


        vec4 getIBLVolumeRefraction( const in vec3 n, const in vec3 v, const in float roughness, const in vec3 diffuseColor,
                const in vec3 specularColor, const in float specularF90, const in vec3 position, const in mat4 modelMatrix,
                const in mat4 viewMatrix, const in mat4 projMatrix, const in float ior, const in float thickness,
                const in vec3 attenuationColor, const in float attenuationDistance ) {


                vec3 transmissionRay = getVolumeTransmissionRay( n, v, thickness, ior, modelMatrix );
                vec3 refractedRayExit = position + transmissionRay;


                // Project refracted vector on the framebuffer, while mapping to normalized device coordinates.
                vec4 ndcPos = projMatrix * viewMatrix * vec4( refractedRayExit, 1.0 );
                vec2 refractionCoords = ndcPos.xy / ndcPos.w;
                refractionCoords += 1.0;
                refractionCoords /= 2.0;


                // Sample framebuffer to get pixel the refracted ray hits.
                vec4 transmittedLight = getTransmissionSample( refractionCoords, roughness, ior );


                vec3 attenuatedColor = applyVolumeAttenuation( transmittedLight.rgb, length( transmissionRay ), attenuationColor, attenuationDistance );


                // Get the specular component.
                vec3 F = EnvironmentBRDF( n, v, specularColor, specularF90, roughness );


                return vec4( ( 1.0 - F ) * attenuatedColor * diffuseColor, transmittedLight.a );


        }
#endif




#if NUM_SPOT_LIGHT_COORDS > 0


  varying vec4 vSpotLightCoord[ NUM_SPOT_LIGHT_COORDS ];


#endif


#if NUM_SPOT_LIGHT_MAPS > 0


  uniform sampler2D spotLightMap[ NUM_SPOT_LIGHT_MAPS ];


#endif


#ifdef USE_SHADOWMAP


        #if NUM_DIR_LIGHT_SHADOWS > 0


                uniform sampler2D directionalShadowMap[ NUM_DIR_LIGHT_SHADOWS ];
                varying vec4 vDirectionalShadowCoord[ NUM_DIR_LIGHT_SHADOWS ];


                struct DirectionalLightShadow {
                        float shadowBias;
                        float shadowNormalBias;
                        float shadowRadius;
                        vec2 shadowMapSize;
                };


                uniform DirectionalLightShadow directionalLightShadows[ NUM_DIR_LIGHT_SHADOWS ];


        #endif


        #if NUM_SPOT_LIGHT_SHADOWS > 0


                uniform sampler2D spotShadowMap[ NUM_SPOT_LIGHT_SHADOWS ];


                struct SpotLightShadow {
                        float shadowBias;
                        float shadowNormalBias;
                        float shadowRadius;
                        vec2 shadowMapSize;
                };


                uniform SpotLightShadow spotLightShadows[ NUM_SPOT_LIGHT_SHADOWS ];


        #endif


        #if NUM_POINT_LIGHT_SHADOWS > 0


                uniform sampler2D pointShadowMap[ NUM_POINT_LIGHT_SHADOWS ];
                varying vec4 vPointShadowCoord[ NUM_POINT_LIGHT_SHADOWS ];


                struct PointLightShadow {
                        float shadowBias;
                        float shadowNormalBias;
                        float shadowRadius;
                        vec2 shadowMapSize;
                        float shadowCameraNear;
                        float shadowCameraFar;
                };


                uniform PointLightShadow pointLightShadows[ NUM_POINT_LIGHT_SHADOWS ];


        #endif


        /*
        #if NUM_RECT_AREA_LIGHTS > 0


                // TODO (abelnation): create uniforms for area light shadows


        #endif
        */


        float texture2DCompare( sampler2D depths, vec2 uv, float compare ) {


                return step( compare, unpackRGBAToDepth( texture( depths, uv ) ) );


        }


        vec2 texture2DDistribution( sampler2D shadow, vec2 uv ) {


                return unpackRGBATo2Half( texture( shadow, uv ) );


        }


        float VSMShadow (sampler2D shadow, vec2 uv, float compare ){


                float occlusion = 1.0;


                vec2 distribution = texture2DDistribution( shadow, uv );


                float hard_shadow = step( compare , distribution.x ); // Hard Shadow


                if (hard_shadow != 1.0 ) {


                        float distance = compare - distribution.x ;
                        float variance = max( 0.00000, distribution.y * distribution.y );
                        float softness_probability = variance / (variance + distance * distance ); // Chebeyshevs inequality
                        softness_probability = clamp( ( softness_probability - 0.3 ) / ( 0.95 - 0.3 ), 0.0, 1.0 ); // 0.3 reduces light bleed
                        occlusion = clamp( max( hard_shadow, softness_probability ), 0.0, 1.0 );


                }
                return occlusion;


        }


        float getShadow( sampler2D shadowMap, vec2 shadowMapSize, float shadowBias, float shadowRadius, vec4 shadowCoord ) {


                float shadow = 1.0;


                shadowCoord.xyz /= shadowCoord.w;
                shadowCoord.z += shadowBias;


                bool inFrustum = shadowCoord.x >= 0.0 && shadowCoord.x <= 1.0 && shadowCoord.y >= 0.0 && shadowCoord.y <= 1.0;
                bool frustumTest = inFrustum && shadowCoord.z <= 1.0;


                if ( frustumTest ) {


                #if defined( SHADOWMAP_TYPE_PCF )


                        vec2 texelSize = vec2( 1.0 ) / shadowMapSize;


                        float dx0 = - texelSize.x * shadowRadius;
                        float dy0 = - texelSize.y * shadowRadius;
                        float dx1 = + texelSize.x * shadowRadius;
                        float dy1 = + texelSize.y * shadowRadius;
                        float dx2 = dx0 / 2.0;
                        float dy2 = dy0 / 2.0;
                        float dx3 = dx1 / 2.0;
                        float dy3 = dy1 / 2.0;


                        shadow = (
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx0, dy0 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy0 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx1, dy0 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx2, dy2 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy2 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx3, dy2 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx0, 0.0 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx2, 0.0 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy, shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx3, 0.0 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx1, 0.0 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx2, dy3 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy3 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx3, dy3 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx0, dy1 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( 0.0, dy1 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, shadowCoord.xy + vec2( dx1, dy1 ), shadowCoord.z )
                        ) * ( 1.0 / 17.0 );


                #elif defined( SHADOWMAP_TYPE_PCF_SOFT )


                        vec2 texelSize = vec2( 1.0 ) / shadowMapSize;
                        float dx = texelSize.x;
                        float dy = texelSize.y;


                        vec2 uv = shadowCoord.xy;
                        vec2 f = fract( uv * shadowMapSize + 0.5 );
                        uv -= f * texelSize;


                        shadow = (
                                texture2DCompare( shadowMap, uv, shadowCoord.z ) +
                                texture2DCompare( shadowMap, uv + vec2( dx, 0.0 ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, uv + vec2( 0.0, dy ), shadowCoord.z ) +
                                texture2DCompare( shadowMap, uv + texelSize, shadowCoord.z ) +
                                mix( texture2DCompare( shadowMap, uv + vec2( -dx, 0.0 ), shadowCoord.z ),
                                         texture2DCompare( shadowMap, uv + vec2( 2.0 * dx, 0.0 ), shadowCoord.z ),
                                         f.x ) +
                                mix( texture2DCompare( shadowMap, uv + vec2( -dx, dy ), shadowCoord.z ),
                                         texture2DCompare( shadowMap, uv + vec2( 2.0 * dx, dy ), shadowCoord.z ),
                                         f.x ) +
                                mix( texture2DCompare( shadowMap, uv + vec2( 0.0, -dy ), shadowCoord.z ),
                                         texture2DCompare( shadowMap, uv + vec2( 0.0, 2.0 * dy ), shadowCoord.z ),
                                         f.y ) +
                                mix( texture2DCompare( shadowMap, uv + vec2( dx, -dy ), shadowCoord.z ),
                                         texture2DCompare( shadowMap, uv + vec2( dx, 2.0 * dy ), shadowCoord.z ),
                                         f.y ) +
                                mix( mix( texture2DCompare( shadowMap, uv + vec2( -dx, -dy ), shadowCoord.z ),
                                                  texture2DCompare( shadowMap, uv + vec2( 2.0 * dx, -dy ), shadowCoord.z ),
                                                  f.x ),
                                         mix( texture2DCompare( shadowMap, uv + vec2( -dx, 2.0 * dy ), shadowCoord.z ),
                                                  texture2DCompare( shadowMap, uv + vec2( 2.0 * dx, 2.0 * dy ), shadowCoord.z ),
                                                  f.x ),
                                         f.y )
                        ) * ( 1.0 / 9.0 );


                #elif defined( SHADOWMAP_TYPE_VSM )


                        shadow = VSMShadow( shadowMap, shadowCoord.xy, shadowCoord.z );


                #else // no percentage-closer filtering:


                        shadow = texture2DCompare( shadowMap, shadowCoord.xy, shadowCoord.z );


                #endif


                }


                return shadow;


        }


        // cubeToUV() maps a 3D direction vector suitable for cube texture mapping to a 2D
        // vector suitable for 2D texture mapping. This code uses the following layout for the
        // 2D texture:
        //
        // xzXZ
        //  y Y
        //
        // Y - Positive y direction
        // y - Negative y direction
        // X - Positive x direction
        // x - Negative x direction
        // Z - Positive z direction
        // z - Negative z direction
        //
        // Source and test bed:
        // https://gist.github.com/tschw/da10c43c467ce8afd0c4


        vec2 cubeToUV( vec3 v, float texelSizeY ) {


                // Number of texels to avoid at the edge of each square


                vec3 absV = abs( v );


                // Intersect unit cube


                float scaleToCube = 1.0 / max( absV.x, max( absV.y, absV.z ) );
                absV *= scaleToCube;


                // Apply scale to avoid seams


                // two texels less per square (one texel will do for NEAREST)
                v *= scaleToCube * ( 1.0 - 2.0 * texelSizeY );


                // Unwrap


                // space: -1 ... 1 range for each square
                //
                // #X##                dim    := ( 4 , 2 )
                //  # #                center := ( 1 , 1 )


                vec2 planar = v.xy;


                float almostATexel = 1.5 * texelSizeY;
                float almostOne = 1.0 - almostATexel;


                if ( absV.z >= almostOne ) {


                        if ( v.z > 0.0 )
                                planar.x = 4.0 - v.x;


                } else if ( absV.x >= almostOne ) {


                        float signX = sign( v.x );
                        planar.x = v.z * signX + 2.0 * signX;


                } else if ( absV.y >= almostOne ) {


                        float signY = sign( v.y );
                        planar.x = v.x + 2.0 * signY + 2.0;
                        planar.y = v.z * signY - 2.0;


                }


                // Transform to UV space


                // scale := 0.5 / dim
                // translate := ( center + 0.5 ) / dim
                return vec2( 0.125, 0.25 ) * planar + vec2( 0.375, 0.75 );


        }


        float getPointShadow( sampler2D shadowMap, vec2 shadowMapSize, float shadowBias, float shadowRadius, vec4 shadowCoord, float shadowCameraNear, float shadowCameraFar ) {


                vec2 texelSize = vec2( 1.0 ) / ( shadowMapSize * vec2( 4.0, 2.0 ) );


                // for point lights, the uniform @vShadowCoord is re-purposed to hold
                // the vector from the light to the world-space position of the fragment.
                vec3 lightToPosition = shadowCoord.xyz;


                // dp = normalized distance from light to fragment position
                float dp = ( length( lightToPosition ) - shadowCameraNear ) / ( ( shadowCameraFar - shadowCameraNear ) ); // need to clamp?
                dp += shadowBias;


                // bd3D = base direction 3D
                vec3 bd3D = normalize( lightToPosition );


                #if defined( SHADOWMAP_TYPE_PCF ) || defined( SHADOWMAP_TYPE_PCF_SOFT ) || defined( SHADOWMAP_TYPE_VSM )


                        vec2 offset = vec2( - 1, 1 ) * shadowRadius * texelSize.y;


                        return (
                                texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xyy, texelSize.y ), dp ) +
                                texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yyy, texelSize.y ), dp ) +
                                texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xyx, texelSize.y ), dp ) +
                                texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yyx, texelSize.y ), dp ) +
                                texture2DCompare( shadowMap, cubeToUV( bd3D, texelSize.y ), dp ) +
                                texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xxy, texelSize.y ), dp ) +
                                texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yxy, texelSize.y ), dp ) +
                                texture2DCompare( shadowMap, cubeToUV( bd3D + offset.xxx, texelSize.y ), dp ) +
                                texture2DCompare( shadowMap, cubeToUV( bd3D + offset.yxx, texelSize.y ), dp )
                        ) * ( 1.0 / 9.0 );


                #else // no percentage-closer filtering


                        return texture2DCompare( shadowMap, cubeToUV( bd3D, texelSize.y ), dp );


                #endif


        }


#endif




#ifdef USE_BUMPMAP


        uniform sampler2D bumpMap;
        uniform float bumpScale;


        // Bump Mapping Unparametrized Surfaces on the GPU by Morten S. Mikkelsen
        // https://mmikk.github.io/papers3d/mm_sfgrad_bump.pdf


        // Evaluate the derivative of the height w.r.t. screen-space using forward differencing (listing 2)


        vec2 dHdxy_fwd() {


                vec2 dSTdx = dFdx( vUv );
                vec2 dSTdy = dFdy( vUv );


                float Hll = bumpScale * texture( bumpMap, vUv ).x;
                float dBx = bumpScale * texture( bumpMap, vUv + dSTdx ).x - Hll;
                float dBy = bumpScale * texture( bumpMap, vUv + dSTdy ).x - Hll;


                return vec2( dBx, dBy );


        }


        vec3 perturbNormalArb( vec3 surf_pos, vec3 surf_norm, vec2 dHdxy, float faceDirection ) {


                vec3 vSigmaX = dFdx( surf_pos.xyz );
                vec3 vSigmaY = dFdy( surf_pos.xyz );
                vec3 vN = surf_norm; // normalized


                vec3 R1 = cross( vSigmaY, vN );
                vec3 R2 = cross( vN, vSigmaX );


                float fDet = dot( vSigmaX, R1 ) * faceDirection;


                vec3 vGrad = sign( fDet ) * ( dHdxy.x * R1 + dHdxy.y * R2 );
                return normalize( abs( fDet ) * surf_norm - vGrad );


        }


#endif




#ifdef USE_NORMALMAP


        uniform sampler2D normalMap;
        uniform vec2 normalScale;


#endif


#ifdef OBJECTSPACE_NORMALMAP


        uniform mat3 normalMatrix;


#endif


#if ! defined ( USE_TANGENT ) && ( defined ( TANGENTSPACE_NORMALMAP ) || defined ( USE_CLEARCOAT_NORMALMAP ) )


        // Normal Mapping Without Precomputed Tangents
        // http://www.thetenthplanet.de/archives/1180


        vec3 perturbNormal2Arb( vec3 eye_pos, vec3 surf_norm, vec3 mapN, float faceDirection ) {


                vec3 q0 = dFdx( eye_pos.xyz );
                vec3 q1 = dFdy( eye_pos.xyz );
                vec2 st0 = dFdx( vUv.st );
                vec2 st1 = dFdy( vUv.st );


                vec3 N = surf_norm; // normalized


                vec3 q1perp = cross( q1, N );
                vec3 q0perp = cross( N, q0 );


                vec3 T = q1perp * st0.x + q0perp * st1.x;
                vec3 B = q1perp * st0.y + q0perp * st1.y;


                float det = max( dot( T, T ), dot( B, B ) );
                float scale = ( det == 0.0 ) ? 0.0 : faceDirection * inversesqrt( det );


                return normalize( T * ( mapN.x * scale ) + B * ( mapN.y * scale ) + N * mapN.z );


        }


#endif






#ifdef USE_CLEARCOATMAP


        uniform sampler2D clearcoatMap;


#endif


#ifdef USE_CLEARCOAT_ROUGHNESSMAP


        uniform sampler2D clearcoatRoughnessMap;


#endif


#ifdef USE_CLEARCOAT_NORMALMAP


        uniform sampler2D clearcoatNormalMap;
        uniform vec2 clearcoatNormalScale;


#endif






#ifdef USE_IRIDESCENCEMAP


        uniform sampler2D iridescenceMap;


#endif


#ifdef USE_IRIDESCENCE_THICKNESSMAP


        uniform sampler2D iridescenceThicknessMap;


#endif




#ifdef USE_ROUGHNESSMAP


        uniform sampler2D roughnessMap;


#endif




#ifdef USE_METALNESSMAP


        uniform sampler2D metalnessMap;


#endif




#if defined( USE_LOGDEPTHBUF ) && defined( USE_LOGDEPTHBUF_EXT )


        uniform float logDepthBufFC;
        varying float vFragDepth;
        varying float vIsPerspective;


#endif




#if NUM_CLIPPING_PLANES > 0


        varying vec3 vClipPosition;


        uniform vec4 clippingPlanes[ NUM_CLIPPING_PLANES ];


#endif




void main() {








#if NUM_CLIPPING_PLANES > 0


        vec4 plane;


        #pragma unroll_loop_start
        for ( int i = 0; i < UNION_CLIPPING_PLANES; i ++ ) {


                plane = clippingPlanes[ i ];
                if ( dot( vClipPosition, plane.xyz ) > plane.w ) discard;


        }
        #pragma unroll_loop_end


        #if UNION_CLIPPING_PLANES < NUM_CLIPPING_PLANES


                bool clipped = true;


                #pragma unroll_loop_start
                for ( int i = UNION_CLIPPING_PLANES; i < NUM_CLIPPING_PLANES; i ++ ) {


                        plane = clippingPlanes[ i ];
                        clipped = ( dot( vClipPosition, plane.xyz ) > plane.w ) && clipped;


                }
                #pragma unroll_loop_end


                if ( clipped ) discard;


        #endif


#endif




        vec4 diffuseColor = vec4( 0.0 );
        ReflectedLight reflectedLight = ReflectedLight( vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ), vec3( 0.0 ) );
        vec3 totalEmissiveRadiance = vec3( 0.0 );




#if defined( USE_LOGDEPTHBUF ) && defined( USE_LOGDEPTHBUF_EXT )


        // Doing a strict comparison with == 1.0 can cause noise artifacts
        // on some platforms. See issue #17623.
        gl_FragDepthEXT = vIsPerspective == 0.0 ? gl_FragCoord.z : log2( vFragDepth ) * logDepthBufFC * 0.5;


#endif




#ifdef USE_MAP


        vec4 sampledDiffuseColor = texture( map, vUv );


        #ifdef DECODE_VIDEO_TEXTURE


                // inline sRGB decode (TODO: Remove this code when https://crbug.com/1256340 is solved)


                sampledDiffuseColor = vec4( mix( pow( sampledDiffuseColor.rgb * 0.9478672986 + vec3( 0.0521327014 ), vec3( 2.4 ) ), sampledDiffuseColor.rgb * 0.0773993808, vec3( lessThanEqual( sampledDiffuseColor.rgb, vec3( 0.04045 ) ) ) ), sampledDiffuseColor.w );


        #endif


        diffuseColor *= sampledDiffuseColor;


#endif




#if defined( USE_COLOR_ALPHA )


        diffuseColor *= vColor;


#elif defined( USE_COLOR )


        diffuseColor.rgb *= vColor;


#endif


nodeVar0 = (normalize(nodeVary0));
        nodeVar1 = u_viewDirection;
        nodeVar2 = customFn_ZNRPnAsn6VSm(  );
        nodeVar3 = (nodeVary2 * vec2( 1, 1 ) + vec2( 0, 0 ));
        nodeVar4 = ( u_time * -0.01 );
        nodeVar5 = nodeVar4;
        nodeVar6 = nodeVar5 * vec2( 1, 1 ) + nodeVar3;
        nodeVar7 = vec2( 0, 0 );
        nodeVar8 = vec2( 0, 0 );
        nodeVar9 = customFn_cFnlRYi2pQL5( nodeVar6, 45.0, 100.0, 0.0, nodeVar7, nodeVar8 );
        nodeVar10 = customFn_2uRokZvecmTz( nodeVar9 );
        nodeVar11 = ( u_time * 1.0 );
        nodeVar12 = nodeVar11;
        nodeVar13 = nodeVar12 * vec2( 0.05, 0.05 ) + nodeVar3;
        nodeVar14 = customFn_HnMwzeEVmWOL( nodeVar13, 125.0 );
        nodeVar15 = customFn_PuOQRLGBkl6g( vec2( nodeVar14 ), vec2( 3.141592653589793 ), 1.0 );
        nodeVar16 = ( nodeVar15 * vec2( 2.0 ) );
        nodeVar17 = ( texture( nodeUniform0, nodeVar16 ) );
        nodeVar18 = customFn_MTmovrkvsCm5( nodeVar17.x );
        nodeVar19 = ( nodeVar10 - nodeVar18 );
        nodeVar20 = customFn_roVdygqiukxY( nodeVar17.x );
        nodeVar21 = (mix(nodeVar19, nodeVar20, vec4( vec3( 0.5 ), 1.0 )));
                
        nodeVar22 = ( nodeVar10 * nodeVar21 );
        nodeVar23 = ( u_time * 1.0 );
        nodeVar24 = nodeVar23;
        nodeVar25 = nodeVar24 * vec2( 0.15, 0.075 ) + nodeVary2;
        nodeVar26 = customFn_FYOsVQx113n6( nodeVar25, 2.0 );
        nodeVar27 = customFn_9ljrgZ7GAWwS( nodeVar26 );
        nodeVar28 = customFn_c61HDgpPM9fI( nodeVar13, 333.0 );
        nodeVar29 = customFn_Qvy092QDMXHT( nodeVar28 );
        nodeVar30 = ( nodeVar27 + nodeVar29 );
        nodeVar31 = customFn_p6S3ehdL7EI5( nodeVar30, vec4( vec3( 0.0 ), 1.0 ), vec4( vec3( 1.0 ), 1.0 ), vec4( vec3( 0.2 ), 1.0 ), vec4( vec3( 0.83 ), 1.0 ) );
        nodeVar32 = customFn_0ZhZ8Fk4N4y5( nodeVar31.x );
        nodeVar33 = ( nodeVar22 + nodeVar32 );
        nodeVar34 = ( vec4( vec3( nodeVar2 ), 1.0 ) * nodeVar33 );
        nodeVar35 = ( nodeVar34.xyz * vec3( 1, 1, 1 ) );
        
        diffuseColor = vec4( nodeVar35, 1.0 );




#ifdef USE_ALPHAMAP


        diffuseColor.a *= texture( alphaMap, vUv ).g;


#endif




#ifdef USE_ALPHATEST


        if ( diffuseColor.a < alphaTest ) discard;


#endif




float roughnessFactor = 0.0;


#ifdef USE_ROUGHNESSMAP


        vec4 texelRoughness = texture( roughnessMap, vUv );


        // reads channel G, compatible with a combined OcclusionRoughnessMetallic (RGB) texture
        roughnessFactor *= texelRoughness.g;


#endif




        roughnessFactor = 0.0;




float metalnessFactor = 0.0;


#ifdef USE_METALNESSMAP


        vec4 texelMetalness = texture( metalnessMap, vUv );


        // reads channel B, compatible with a combined OcclusionRoughnessMetallic (RGB) texture
        metalnessFactor *= texelMetalness.b;


#endif




float faceDirection = gl_FrontFacing ? 1.0 : - 1.0;


#ifdef FLAT_SHADED


        vec3 fdx = dFdx( vViewPosition );
        vec3 fdy = dFdy( vViewPosition );
        vec3 normal = normalize( cross( fdx, fdy ) );


#else


        vec3 normal = normalize( vNormal );


        #ifdef DOUBLE_SIDED


                normal = normal * faceDirection;


        #endif


        #ifdef USE_TANGENT


                vec3 tangent = normalize( vTangent );
                vec3 bitangent = normalize( vBitangent );


                #ifdef DOUBLE_SIDED


                        tangent = tangent * faceDirection;
                        bitangent = bitangent * faceDirection;


                #endif


                #if defined( TANGENTSPACE_NORMALMAP ) || defined( USE_CLEARCOAT_NORMALMAP )


                        mat3 vTBN = mat3( tangent, bitangent, normal );


                #endif


        #endif


#endif


// non perturbed normal for clearcoat among others


vec3 geometryNormal = normal;






        vec3 mapN = nodeVar33.xyz * 2.0 - 1.0;
        mapN.xy *= normalScale;
        normal = normalize(vTBN * mapN);


        


#ifdef USE_CLEARCOAT


        vec3 clearcoatNormal = geometryNormal;


#endif




#ifdef USE_CLEARCOAT_NORMALMAP


        vec3 clearcoatMapN = texture( clearcoatNormalMap, vUv ).xyz * 2.0 - 1.0;
        clearcoatMapN.xy *= clearcoatNormalScale;


        #ifdef USE_TANGENT


                clearcoatNormal = normalize( vTBN * clearcoatMapN );


        #else


                clearcoatNormal = perturbNormal2Arb( - vViewPosition, clearcoatNormal, clearcoatMapN, faceDirection );


        #endif


#endif




#ifdef USE_EMISSIVEMAP


        vec4 emissiveColor = texture( emissiveMap, vUv );


        totalEmissiveRadiance *= emissiveColor.rgb;


#endif




        totalEmissiveRadiance = nodeVar32.xyz * vec3(1);




        // accumulation


PhysicalMaterial material;
material.diffuseColor = diffuseColor.rgb * ( 1.0 - metalnessFactor );


vec3 dxy = max( abs( dFdx( geometryNormal ) ), abs( dFdy( geometryNormal ) ) );
float geometryRoughness = max( max( dxy.x, dxy.y ), dxy.z );


material.roughness = max( roughnessFactor, 0.0525 );// 0.0525 corresponds to the base mip of a 256 cubemap.
material.roughness += geometryRoughness;
material.roughness = min( material.roughness, 1.0 );


#ifdef IOR


        material.ior = ior;


        #ifdef SPECULAR


                float specularIntensityFactor = specularIntensity;
                vec3 specularColorFactor = specularColor;


                #ifdef USE_SPECULARINTENSITYMAP


                        specularIntensityFactor *= texture( specularIntensityMap, vUv ).a;


                #endif


                #ifdef USE_SPECULARCOLORMAP


                        specularColorFactor *= texture( specularColorMap, vUv ).rgb;


                #endif


                material.specularF90 = mix( specularIntensityFactor, 1.0, metalnessFactor );


        #else


                float specularIntensityFactor = 1.0;
                vec3 specularColorFactor = vec3( 1.0 );
                material.specularF90 = 1.0;


        #endif


        material.specularColor = mix( min( pow2( ( material.ior - 1.0 ) / ( material.ior + 1.0 ) ) * specularColorFactor, vec3( 1.0 ) ) * specularIntensityFactor, diffuseColor.rgb, metalnessFactor );


#else


        material.specularColor = mix( vec3( 0.04 ), diffuseColor.rgb, metalnessFactor );
        material.specularF90 = 1.0;


#endif


#ifdef USE_CLEARCOAT


        material.clearcoat = clearcoat;
        material.clearcoatRoughness = clearcoatRoughness;
        material.clearcoatF0 = vec3( 0.04 );
        material.clearcoatF90 = 1.0;


        #ifdef USE_CLEARCOATMAP


                material.clearcoat *= texture( clearcoatMap, vUv ).x;


        #endif


        #ifdef USE_CLEARCOAT_ROUGHNESSMAP


                material.clearcoatRoughness *= texture( clearcoatRoughnessMap, vUv ).y;


        #endif


        material.clearcoat = saturate( material.clearcoat ); // Burley clearcoat model
        material.clearcoatRoughness = max( material.clearcoatRoughness, 0.0525 );
        material.clearcoatRoughness += geometryRoughness;
        material.clearcoatRoughness = min( material.clearcoatRoughness, 1.0 );


#endif


#ifdef USE_IRIDESCENCE


        material.iridescence = iridescence;
        material.iridescenceIOR = iridescenceIOR;


        #ifdef USE_IRIDESCENCEMAP


                material.iridescence *= texture( iridescenceMap, vUv ).r;


        #endif


        #ifdef USE_IRIDESCENCE_THICKNESSMAP


                material.iridescenceThickness = (iridescenceThicknessMaximum - iridescenceThicknessMinimum) * texture( iridescenceThicknessMap, vUv ).g + iridescenceThicknessMinimum;


        #else


                material.iridescenceThickness = iridescenceThicknessMaximum;


        #endif


#endif


#ifdef USE_SHEEN


        material.sheenColor = sheenColor;


        #ifdef USE_SHEENCOLORMAP


                material.sheenColor *= texture( sheenColorMap, vUv ).rgb;


        #endif


        material.sheenRoughness = clamp( sheenRoughness, 0.07, 1.0 );


        #ifdef USE_SHEENROUGHNESSMAP


                material.sheenRoughness *= texture( sheenRoughnessMap, vUv ).a;


        #endif


#endif




/**
 * This is a template that can be used to light a material, it uses pluggable
 * RenderEquations (RE)for specific lighting scenarios.
 *
 * Instructions for use:
 * - Ensure that both RE_Direct, RE_IndirectDiffuse and RE_IndirectSpecular are defined
 * - Create a material parameter that is to be passed as the third parameter to your lighting functions.
 *
 * TODO:
 * - Add area light support.
 * - Add sphere light support.
 * - Add diffuse light probe (irradiance cubemap) support.
 */


GeometricContext geometry;


geometry.position = - vViewPosition;
geometry.normal = normal;
geometry.viewDir = ( isOrthographic ) ? vec3( 0, 0, 1 ) : normalize( vViewPosition );


#ifdef USE_CLEARCOAT


        geometry.clearcoatNormal = clearcoatNormal;


#endif


#ifdef USE_IRIDESCENCE


        float dotNVi = saturate( dot( normal, geometry.viewDir ) );


        if ( material.iridescenceThickness == 0.0 ) {


                material.iridescence = 0.0;


        } else {


                material.iridescence = saturate( material.iridescence );


        }


        if ( material.iridescence > 0.0 ) {


                material.iridescenceFresnel = evalIridescence( 1.0, material.iridescenceIOR, dotNVi, material.iridescenceThickness, material.specularColor );


                // Iridescence F0 approximation
                material.iridescenceF0 = Schlick_to_F0( material.iridescenceFresnel, 1.0, dotNVi );


        }


#endif


IncidentLight directLight;


#if ( NUM_POINT_LIGHTS > 0 ) && defined( RE_Direct )


        PointLight pointLight;
        #if defined( USE_SHADOWMAP ) && NUM_POINT_LIGHT_SHADOWS > 0
        PointLightShadow pointLightShadow;
        #endif


        #pragma unroll_loop_start
        for ( int i = 0; i < NUM_POINT_LIGHTS; i ++ ) {


                pointLight = pointLights[ i ];


                getPointLightInfo( pointLight, geometry, directLight );


                #if defined( USE_SHADOWMAP ) && ( UNROLLED_LOOP_INDEX < NUM_POINT_LIGHT_SHADOWS )
                pointLightShadow = pointLightShadows[ i ];
                directLight.color *= ( directLight.visible && receiveShadow ) ? getPointShadow( pointShadowMap[ i ], pointLightShadow.shadowMapSize, pointLightShadow.shadowBias, pointLightShadow.shadowRadius, vPointShadowCoord[ i ], pointLightShadow.shadowCameraNear, pointLightShadow.shadowCameraFar ) : 1.0;
                #endif


                RE_Direct( directLight, geometry, material, reflectedLight );


        }
        #pragma unroll_loop_end


#endif


#if ( NUM_SPOT_LIGHTS > 0 ) && defined( RE_Direct )


        SpotLight spotLight;
        vec4 spotColor;
        vec3 spotLightCoord;
        bool inSpotLightMap;


        #if defined( USE_SHADOWMAP ) && NUM_SPOT_LIGHT_SHADOWS > 0
        SpotLightShadow spotLightShadow;
        #endif


        #pragma unroll_loop_start
        for ( int i = 0; i < NUM_SPOT_LIGHTS; i ++ ) {


                spotLight = spotLights[ i ];


                getSpotLightInfo( spotLight, geometry, directLight );


                // spot lights are ordered [shadows with maps, shadows without maps, maps without shadows, none]
                #if ( UNROLLED_LOOP_INDEX < NUM_SPOT_LIGHT_SHADOWS_WITH_MAPS )
                #define SPOT_LIGHT_MAP_INDEX UNROLLED_LOOP_INDEX
                #elif ( UNROLLED_LOOP_INDEX < NUM_SPOT_LIGHT_SHADOWS )
                #define SPOT_LIGHT_MAP_INDEX NUM_SPOT_LIGHT_MAPS
                #else
                #define SPOT_LIGHT_MAP_INDEX ( UNROLLED_LOOP_INDEX - NUM_SPOT_LIGHT_SHADOWS + NUM_SPOT_LIGHT_SHADOWS_WITH_MAPS )
                #endif


                #if ( SPOT_LIGHT_MAP_INDEX < NUM_SPOT_LIGHT_MAPS )
                        spotLightCoord = vSpotLightCoord[ i ].xyz / vSpotLightCoord[ i ].w;
                        inSpotLightMap = all( lessThan( abs( spotLightCoord * 2. - 1. ), vec3( 1.0 ) ) );
                        spotColor = texture( spotLightMap[ SPOT_LIGHT_MAP_INDEX ], spotLightCoord.xy );
                        directLight.color = inSpotLightMap ? directLight.color * spotColor.rgb : directLight.color;
                #endif


                #undef SPOT_LIGHT_MAP_INDEX


                #if defined( USE_SHADOWMAP ) && ( UNROLLED_LOOP_INDEX < NUM_SPOT_LIGHT_SHADOWS )
                spotLightShadow = spotLightShadows[ i ];
                directLight.color *= ( directLight.visible && receiveShadow ) ? getShadow( spotShadowMap[ i ], spotLightShadow.shadowMapSize, spotLightShadow.shadowBias, spotLightShadow.shadowRadius, vSpotLightCoord[ i ] ) : 1.0;
                #endif


                RE_Direct( directLight, geometry, material, reflectedLight );


        }
        #pragma unroll_loop_end


#endif


#if ( NUM_DIR_LIGHTS > 0 ) && defined( RE_Direct )


        DirectionalLight directionalLight;
        #if defined( USE_SHADOWMAP ) && NUM_DIR_LIGHT_SHADOWS > 0
        DirectionalLightShadow directionalLightShadow;
        #endif


        #pragma unroll_loop_start
        for ( int i = 0; i < NUM_DIR_LIGHTS; i ++ ) {


                directionalLight = directionalLights[ i ];


                getDirectionalLightInfo( directionalLight, geometry, directLight );


                #if defined( USE_SHADOWMAP ) && ( UNROLLED_LOOP_INDEX < NUM_DIR_LIGHT_SHADOWS )
                directionalLightShadow = directionalLightShadows[ i ];
                directLight.color *= ( directLight.visible && receiveShadow ) ? getShadow( directionalShadowMap[ i ], directionalLightShadow.shadowMapSize, directionalLightShadow.shadowBias, directionalLightShadow.shadowRadius, vDirectionalShadowCoord[ i ] ) : 1.0;
                #endif


                RE_Direct( directLight, geometry, material, reflectedLight );


        }
        #pragma unroll_loop_end


#endif


#if ( NUM_RECT_AREA_LIGHTS > 0 ) && defined( RE_Direct_RectArea )


        RectAreaLight rectAreaLight;


        #pragma unroll_loop_start
        for ( int i = 0; i < NUM_RECT_AREA_LIGHTS; i ++ ) {


                rectAreaLight = rectAreaLights[ i ];
                RE_Direct_RectArea( rectAreaLight, geometry, material, reflectedLight );


        }
        #pragma unroll_loop_end


#endif


#if defined( RE_IndirectDiffuse )


        vec3 iblIrradiance = vec3( 0.0 );


        vec3 irradiance = getAmbientLightIrradiance( ambientLightColor );


        irradiance += getLightProbeIrradiance( lightProbe, geometry.normal );


        #if ( NUM_HEMI_LIGHTS > 0 )


                #pragma unroll_loop_start
                for ( int i = 0; i < NUM_HEMI_LIGHTS; i ++ ) {


                        irradiance += getHemisphereLightIrradiance( hemisphereLights[ i ], geometry.normal );


                }
                #pragma unroll_loop_end


        #endif


#endif


#if defined( RE_IndirectSpecular )


        vec3 radiance = vec3( 0.0 );
        vec3 clearcoatRadiance = vec3( 0.0 );


#endif




#if defined( RE_IndirectDiffuse )


        #ifdef USE_LIGHTMAP


                vec4 lightMapTexel = texture( lightMap, vUv2 );
                vec3 lightMapIrradiance = lightMapTexel.rgb * lightMapIntensity;


                irradiance += lightMapIrradiance;


        #endif


        #if defined( USE_ENVMAP ) && defined( STANDARD ) && defined( ENVMAP_TYPE_CUBE_UV )


                iblIrradiance += getIBLIrradiance( geometry.normal );


        #endif


#endif


#if defined( USE_ENVMAP ) && defined( RE_IndirectSpecular )


        radiance += getIBLRadiance( geometry.viewDir, geometry.normal, material.roughness );


        #ifdef USE_CLEARCOAT


                clearcoatRadiance += getIBLRadiance( geometry.viewDir, geometry.clearcoatNormal, material.clearcoatRoughness );


        #endif


#endif




#if defined( RE_IndirectDiffuse )


        RE_IndirectDiffuse( irradiance, geometry, material, reflectedLight );


#endif


#if defined( RE_IndirectSpecular )


        RE_IndirectSpecular( radiance, iblIrradiance, clearcoatRadiance, geometry, material, reflectedLight );


#endif




        // modulation
        


        vec3 totalDiffuse = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse;
        vec3 totalSpecular = reflectedLight.directSpecular + reflectedLight.indirectSpecular;




#ifdef USE_TRANSMISSION


        material.transmission = transmission;
        material.transmissionAlpha = 1.0;
        material.thickness = thickness;
        material.attenuationDistance = attenuationDistance;
        material.attenuationColor = attenuationColor;


        #ifdef USE_TRANSMISSIONMAP


                material.transmission *= texture( transmissionMap, vUv ).r;


        #endif


        #ifdef USE_THICKNESSMAP


                material.thickness *= texture( thicknessMap, vUv ).g;


        #endif


        vec3 pos = vWorldPosition;
        vec3 v = normalize( cameraPosition - pos );
        vec3 n = inverseTransformDirection( normal, viewMatrix );


        vec4 transmission = getIBLVolumeRefraction(
                n, v, material.roughness, material.diffuseColor, material.specularColor, material.specularF90,
                pos, modelMatrix, viewMatrix, projectionMatrix, material.ior, material.thickness,
                material.attenuationColor, material.attenuationDistance );


        material.transmissionAlpha = mix( material.transmissionAlpha, transmission.a, material.transmission );


        totalDiffuse = mix( totalDiffuse, transmission.rgb, material.transmission );


#endif




        vec3 outgoingLight = totalDiffuse + totalSpecular + totalEmissiveRadiance;


        #ifdef USE_SHEEN


                // Sheen energy compensation approximation calculation can be found at the end of
                // https://drive.google.com/file/d/1T0D1VSyR4AllqIJTQAraEIzjlb5h4FKH/view?usp=sharing
                float sheenEnergyComp = 1.0 - 0.157 * max3( material.sheenColor );


                outgoingLight = outgoingLight * sheenEnergyComp + sheenSpecular;


        #endif


        #ifdef USE_CLEARCOAT


                float dotNVcc = saturate( dot( geometry.clearcoatNormal, geometry.viewDir ) );


                vec3 Fcc = F_Schlick( material.clearcoatF0, material.clearcoatF90, dotNVcc );


                outgoingLight = outgoingLight * ( 1.0 - material.clearcoat * Fcc ) + clearcoatSpecular * material.clearcoat;


        #endif




#ifdef OPAQUE
diffuseColor.a = 1.0;
#endif


// https://github.com/mrdoob/three.js/pull/22425
#ifdef USE_TRANSMISSION
diffuseColor.a *= material.transmissionAlpha + 0.1;
#endif


gl_FragColor = vec4( outgoingLight, diffuseColor.a );




#if defined( TONE_MAPPING )


        gl_FragColor.rgb = toneMapping( gl_FragColor.rgb );


#endif




gl_FragColor = linearToOutputTexel( gl_FragColor );




#ifdef USE_FOG


        #ifdef FOG_EXP2


                float fogFactor = 1.0 - exp( - fogDensity * fogDensity * vFogDepth * vFogDepth );


        #else


                float fogFactor = smoothstep( fogNear, fogFar, vFogDepth );


        #endif


        gl_FragColor.rgb = mix( gl_FragColor.rgb, fogColor, fogFactor );


#endif




#ifdef PREMULTIPLIED_ALPHA


        // Get get normal blending with premultipled, use with CustomBlending, OneFactor, OneMinusSrcAlphaFactor, AddEquation.
        gl_FragColor.rgb *= gl_FragColor.a;


#endif




#ifdef DITHERING


        gl_FragColor.rgb = dithering( gl_FragColor.rgb );


#endif




}