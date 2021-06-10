Shader "New Goo Shader"
{
    Properties
    {
        Vector1_8aaaa65e405749e29c4a471ce5c6ce3a("scrollSpeed", Float) = 1
        Vector1_acc4d319559c4c12a59608a560b4772c("subtract", Float) = 0
        Vector1_4053ff97c6de4755a984a3218d675292("edge", Float) = 0
        [NoScaleOffset]Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee("Mask Texture", 2D) = "white" {}
        [NonModifiableTextureData][NoScaleOffset]_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1("Texture2D", 2D) = "white" {}
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Lit"
            "Queue"="Transparent"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_FORWARD
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 lightmapUV;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 sh;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 fogFactorAndVertexLight;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TimeParameters;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 interp4 : TEXCOORD4;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp5 : TEXCOORD5;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp6 : TEXCOORD6;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp7 : TEXCOORD7;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp4.xy =  input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp5.xyz =  input.sh;
            #endif
            output.interp6.xyzw =  input.fogFactorAndVertexLight;
            output.interp7.xyzw =  input.shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.interp4.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp5.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp6.xyzw;
            output.shadowCoord = input.interp7.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        { 
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
        {
            float3 worldDerivativeX = ddx(Position);
            float3 worldDerivativeY = ddy(Position);

            float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
            float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
            float d = dot(worldDerivativeX, crossY);
            float sgn = d < 0.0 ? (-1.0f) : 1.0f;
            float surface = sgn / max(0.000000000000001192093f, abs(d));

            float dHdx = ddx(In);
            float dHdy = ddy(In);
            float3 surfGrad = surface * (dHdx*crossY + dHdy*crossX);
            Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
            Out = TransformWorldToTangent(Out, TangentMatrix);
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float3 Specular;
            float Smoothness;
            float Occlusion;
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_f600530379444a8eb44df6b31c29cb61_Out_0 = Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_faaeeb920c564c97be18882705bfc617_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, _Property_f600530379444a8eb44df6b31c29cb61_Out_0, _Divide_faaeeb920c564c97be18882705bfc617_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3;
            Unity_TilingAndOffset_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, float2 (2, 2), (_Divide_faaeeb920c564c97be18882705bfc617_Out_2.xx), _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2;
            Unity_GradientNoise_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, 12.58, _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_39cf803ea6e04308a6246f49a4590249_Out_2;
            Unity_Divide_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2, 2, _Divide_39cf803ea6e04308a6246f49a4590249_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2;
            Unity_Add_float2(_TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3, (_Divide_39cf803ea6e04308a6246f49a4590249_Out_2.xx), _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0 = SAMPLE_TEXTURE2D(UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).tex, UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).samplerstate, _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.r;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.g;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.b;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_A_7 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2;
            Unity_Add_float(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5, _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2;
            Unity_Add_float(_Add_514c57978a5f46438b8b4f52fcd0117d_Out_2, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6, _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_d1401406247141e18c986afd2ee6bcae_Out_2;
            Unity_Divide_float(_Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2, 3, _Divide_d1401406247141e18c986afd2ee6bcae_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0 = Vector1_acc4d319559c4c12a59608a560b4772c;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2;
            Unity_Subtract_float(_Divide_d1401406247141e18c986afd2ee6bcae_Out_2, _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0, _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1;
            float3x3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position = IN.WorldSpacePosition;
            Unity_NormalFromHeight_Tangent_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2,0.03,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix, _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2;
            Unity_DotProduct_float3(_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1, IN.WorldSpaceViewDirection, _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2;
            Unity_Divide_float(_DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2, 8, _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3;
            Unity_Clamp_float(_Divide_29eeea42a48640aabe125ecb62e01d06_Out_2, 0, 0.05, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_52df3467f68c48139c07c8c757cc127b_Out_2;
            Unity_Add_float(_Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3, _Add_52df3467f68c48139c07c8c757cc127b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.NormalTS = IN.TangentSpaceNormal;
            surface.Emission = (_Add_52df3467f68c48139c07c8c757cc127b_Out_2.xxx);
            surface.Specular = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Smoothness = 1;
            surface.Occlusion = 0;
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "GBuffer"
            Tags
            {
                "LightMode" = "UniversalGBuffer"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
        #pragma multi_compile _ _GBUFFER_NORMALS_OCT
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_GBUFFER
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 lightmapUV;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 sh;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 fogFactorAndVertexLight;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TimeParameters;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 interp4 : TEXCOORD4;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp5 : TEXCOORD5;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp6 : TEXCOORD6;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp7 : TEXCOORD7;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp4.xy =  input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp5.xyz =  input.sh;
            #endif
            output.interp6.xyzw =  input.fogFactorAndVertexLight;
            output.interp7.xyzw =  input.shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.interp4.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp5.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp6.xyzw;
            output.shadowCoord = input.interp7.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        { 
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
        {
            float3 worldDerivativeX = ddx(Position);
            float3 worldDerivativeY = ddy(Position);

            float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
            float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
            float d = dot(worldDerivativeX, crossY);
            float sgn = d < 0.0 ? (-1.0f) : 1.0f;
            float surface = sgn / max(0.000000000000001192093f, abs(d));

            float dHdx = ddx(In);
            float dHdy = ddy(In);
            float3 surfGrad = surface * (dHdx*crossY + dHdy*crossX);
            Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
            Out = TransformWorldToTangent(Out, TangentMatrix);
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float3 Specular;
            float Smoothness;
            float Occlusion;
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_f600530379444a8eb44df6b31c29cb61_Out_0 = Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_faaeeb920c564c97be18882705bfc617_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, _Property_f600530379444a8eb44df6b31c29cb61_Out_0, _Divide_faaeeb920c564c97be18882705bfc617_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3;
            Unity_TilingAndOffset_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, float2 (2, 2), (_Divide_faaeeb920c564c97be18882705bfc617_Out_2.xx), _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2;
            Unity_GradientNoise_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, 12.58, _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_39cf803ea6e04308a6246f49a4590249_Out_2;
            Unity_Divide_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2, 2, _Divide_39cf803ea6e04308a6246f49a4590249_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2;
            Unity_Add_float2(_TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3, (_Divide_39cf803ea6e04308a6246f49a4590249_Out_2.xx), _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0 = SAMPLE_TEXTURE2D(UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).tex, UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).samplerstate, _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.r;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.g;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.b;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_A_7 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2;
            Unity_Add_float(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5, _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2;
            Unity_Add_float(_Add_514c57978a5f46438b8b4f52fcd0117d_Out_2, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6, _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_d1401406247141e18c986afd2ee6bcae_Out_2;
            Unity_Divide_float(_Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2, 3, _Divide_d1401406247141e18c986afd2ee6bcae_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0 = Vector1_acc4d319559c4c12a59608a560b4772c;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2;
            Unity_Subtract_float(_Divide_d1401406247141e18c986afd2ee6bcae_Out_2, _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0, _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1;
            float3x3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position = IN.WorldSpacePosition;
            Unity_NormalFromHeight_Tangent_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2,0.03,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix, _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2;
            Unity_DotProduct_float3(_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1, IN.WorldSpaceViewDirection, _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2;
            Unity_Divide_float(_DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2, 8, _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3;
            Unity_Clamp_float(_Divide_29eeea42a48640aabe125ecb62e01d06_Out_2, 0, 0.05, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_52df3467f68c48139c07c8c757cc127b_Out_2;
            Unity_Add_float(_Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3, _Add_52df3467f68c48139c07c8c757cc127b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.NormalTS = IN.TangentSpaceNormal;
            surface.Emission = (_Add_52df3467f68c48139c07c8c757cc127b_Out_2.xxx);
            surface.Specular = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Smoothness = 1;
            surface.Occlusion = 0;
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_SHADOWCASTER
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHONLY
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile _ DOTS_INSTANCING_ON
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.NormalTS = IN.TangentSpaceNormal;
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }

            // Render State
            Cull Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD2
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_META
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv2 : TEXCOORD2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TimeParameters;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        { 
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
        {
            float3 worldDerivativeX = ddx(Position);
            float3 worldDerivativeY = ddy(Position);

            float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
            float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
            float d = dot(worldDerivativeX, crossY);
            float sgn = d < 0.0 ? (-1.0f) : 1.0f;
            float surface = sgn / max(0.000000000000001192093f, abs(d));

            float dHdx = ddx(In);
            float dHdy = ddy(In);
            float3 surfGrad = surface * (dHdx*crossY + dHdy*crossX);
            Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
            Out = TransformWorldToTangent(Out, TangentMatrix);
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_f600530379444a8eb44df6b31c29cb61_Out_0 = Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_faaeeb920c564c97be18882705bfc617_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, _Property_f600530379444a8eb44df6b31c29cb61_Out_0, _Divide_faaeeb920c564c97be18882705bfc617_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3;
            Unity_TilingAndOffset_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, float2 (2, 2), (_Divide_faaeeb920c564c97be18882705bfc617_Out_2.xx), _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2;
            Unity_GradientNoise_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, 12.58, _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_39cf803ea6e04308a6246f49a4590249_Out_2;
            Unity_Divide_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2, 2, _Divide_39cf803ea6e04308a6246f49a4590249_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2;
            Unity_Add_float2(_TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3, (_Divide_39cf803ea6e04308a6246f49a4590249_Out_2.xx), _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0 = SAMPLE_TEXTURE2D(UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).tex, UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).samplerstate, _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.r;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.g;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.b;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_A_7 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2;
            Unity_Add_float(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5, _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2;
            Unity_Add_float(_Add_514c57978a5f46438b8b4f52fcd0117d_Out_2, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6, _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_d1401406247141e18c986afd2ee6bcae_Out_2;
            Unity_Divide_float(_Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2, 3, _Divide_d1401406247141e18c986afd2ee6bcae_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0 = Vector1_acc4d319559c4c12a59608a560b4772c;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2;
            Unity_Subtract_float(_Divide_d1401406247141e18c986afd2ee6bcae_Out_2, _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0, _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1;
            float3x3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position = IN.WorldSpacePosition;
            Unity_NormalFromHeight_Tangent_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2,0.03,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix, _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2;
            Unity_DotProduct_float3(_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1, IN.WorldSpaceViewDirection, _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2;
            Unity_Divide_float(_DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2, 8, _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3;
            Unity_Clamp_float(_Divide_29eeea42a48640aabe125ecb62e01d06_Out_2, 0, 0.05, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_52df3467f68c48139c07c8c757cc127b_Out_2;
            Unity_Add_float(_Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3, _Add_52df3467f68c48139c07c8c757cc127b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = (_Add_52df3467f68c48139c07c8c757cc127b_Out_2.xxx);
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 4.5
        #pragma exclude_renderers gles gles3 glcore
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_2D
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

            ENDHLSL
        }
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Transparent"
            "UniversalMaterialType" = "Lit"
            "Queue"="Transparent"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma multi_compile _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma multi_compile _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS _ADDITIONAL_OFF
        #pragma multi_compile _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile _ _SHADOWS_SOFT
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_FORWARD
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 lightmapUV;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 sh;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 fogFactorAndVertexLight;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 shadowCoord;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TimeParameters;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 interp4 : TEXCOORD4;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp5 : TEXCOORD5;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp6 : TEXCOORD6;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp7 : TEXCOORD7;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if defined(LIGHTMAP_ON)
            output.interp4.xy =  input.lightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.interp5.xyz =  input.sh;
            #endif
            output.interp6.xyzw =  input.fogFactorAndVertexLight;
            output.interp7.xyzw =  input.shadowCoord;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if defined(LIGHTMAP_ON)
            output.lightmapUV = input.interp4.xy;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.interp5.xyz;
            #endif
            output.fogFactorAndVertexLight = input.interp6.xyzw;
            output.shadowCoord = input.interp7.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        { 
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
        {
            float3 worldDerivativeX = ddx(Position);
            float3 worldDerivativeY = ddy(Position);

            float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
            float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
            float d = dot(worldDerivativeX, crossY);
            float sgn = d < 0.0 ? (-1.0f) : 1.0f;
            float surface = sgn / max(0.000000000000001192093f, abs(d));

            float dHdx = ddx(In);
            float dHdy = ddy(In);
            float3 surfGrad = surface * (dHdx*crossY + dHdy*crossX);
            Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
            Out = TransformWorldToTangent(Out, TangentMatrix);
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float3 Specular;
            float Smoothness;
            float Occlusion;
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_f600530379444a8eb44df6b31c29cb61_Out_0 = Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_faaeeb920c564c97be18882705bfc617_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, _Property_f600530379444a8eb44df6b31c29cb61_Out_0, _Divide_faaeeb920c564c97be18882705bfc617_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3;
            Unity_TilingAndOffset_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, float2 (2, 2), (_Divide_faaeeb920c564c97be18882705bfc617_Out_2.xx), _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2;
            Unity_GradientNoise_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, 12.58, _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_39cf803ea6e04308a6246f49a4590249_Out_2;
            Unity_Divide_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2, 2, _Divide_39cf803ea6e04308a6246f49a4590249_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2;
            Unity_Add_float2(_TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3, (_Divide_39cf803ea6e04308a6246f49a4590249_Out_2.xx), _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0 = SAMPLE_TEXTURE2D(UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).tex, UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).samplerstate, _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.r;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.g;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.b;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_A_7 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2;
            Unity_Add_float(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5, _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2;
            Unity_Add_float(_Add_514c57978a5f46438b8b4f52fcd0117d_Out_2, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6, _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_d1401406247141e18c986afd2ee6bcae_Out_2;
            Unity_Divide_float(_Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2, 3, _Divide_d1401406247141e18c986afd2ee6bcae_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0 = Vector1_acc4d319559c4c12a59608a560b4772c;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2;
            Unity_Subtract_float(_Divide_d1401406247141e18c986afd2ee6bcae_Out_2, _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0, _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1;
            float3x3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position = IN.WorldSpacePosition;
            Unity_NormalFromHeight_Tangent_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2,0.03,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix, _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2;
            Unity_DotProduct_float3(_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1, IN.WorldSpaceViewDirection, _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2;
            Unity_Divide_float(_DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2, 8, _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3;
            Unity_Clamp_float(_Divide_29eeea42a48640aabe125ecb62e01d06_Out_2, 0, 0.05, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_52df3467f68c48139c07c8c757cc127b_Out_2;
            Unity_Add_float(_Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3, _Add_52df3467f68c48139c07c8c757cc127b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.NormalTS = IN.TangentSpaceNormal;
            surface.Emission = (_Add_52df3467f68c48139c07c8c757cc127b_Out_2.xxx);
            surface.Specular = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Smoothness = 1;
            surface.Occlusion = 0;
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_SHADOWCASTER
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On
        ColorMask 0

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHONLY
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite On

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.NormalTS = IN.TangentSpaceNormal;
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal =          float3(0.0f, 0.0f, 1.0f);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }

            // Render State
            Cull Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            #pragma shader_feature _ _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD2
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_META
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 uv2 : TEXCOORD2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 TimeParameters;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Divide_float(float A, float B, out float Out)
        {
            Out = A / B;
        }

        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }


        float2 Unity_GradientNoise_Dir_float(float2 p)
        {
            // Permutation and hashing used in webgl-nosie goo.gl/pX7HtC
            p = p % 289;
            // need full precision, otherwise half overflows when p > 1
            float x = float(34 * p.x + 1) * p.x % 289 + p.y;
            x = (34 * x + 1) * x % 289;
            x = frac(x / 41) * 2 - 1;
            return normalize(float2(x - floor(x + 0.5), abs(x) - 0.5));
        }

        void Unity_GradientNoise_float(float2 UV, float Scale, out float Out)
        { 
            float2 p = UV * Scale;
            float2 ip = floor(p);
            float2 fp = frac(p);
            float d00 = dot(Unity_GradientNoise_Dir_float(ip), fp);
            float d01 = dot(Unity_GradientNoise_Dir_float(ip + float2(0, 1)), fp - float2(0, 1));
            float d10 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 0)), fp - float2(1, 0));
            float d11 = dot(Unity_GradientNoise_Dir_float(ip + float2(1, 1)), fp - float2(1, 1));
            fp = fp * fp * fp * (fp * (fp * 6 - 15) + 10);
            Out = lerp(lerp(d00, d01, fp.y), lerp(d10, d11, fp.y), fp.x) + 0.5;
        }

        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float(float A, float B, out float Out)
        {
            Out = A - B;
        }

        void Unity_NormalFromHeight_Tangent_float(float In, float Strength, float3 Position, float3x3 TangentMatrix, out float3 Out)
        {
            float3 worldDerivativeX = ddx(Position);
            float3 worldDerivativeY = ddy(Position);

            float3 crossX = cross(TangentMatrix[2].xyz, worldDerivativeX);
            float3 crossY = cross(worldDerivativeY, TangentMatrix[2].xyz);
            float d = dot(worldDerivativeX, crossY);
            float sgn = d < 0.0 ? (-1.0f) : 1.0f;
            float surface = sgn / max(0.000000000000001192093f, abs(d));

            float dHdx = ddx(In);
            float dHdy = ddy(In);
            float3 surfGrad = surface * (dHdx*crossY + dHdy*crossX);
            Out = SafeNormalize(TangentMatrix[2].xyz - (Strength * surfGrad));
            Out = TransformWorldToTangent(Out, TangentMatrix);
        }

        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_f600530379444a8eb44df6b31c29cb61_Out_0 = Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_faaeeb920c564c97be18882705bfc617_Out_2;
            Unity_Divide_float(IN.TimeParameters.x, _Property_f600530379444a8eb44df6b31c29cb61_Out_0, _Divide_faaeeb920c564c97be18882705bfc617_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3;
            Unity_TilingAndOffset_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, float2 (2, 2), (_Divide_faaeeb920c564c97be18882705bfc617_Out_2.xx), _TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2;
            Unity_GradientNoise_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, 12.58, _GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_39cf803ea6e04308a6246f49a4590249_Out_2;
            Unity_Divide_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2, 2, _Divide_39cf803ea6e04308a6246f49a4590249_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2;
            Unity_Add_float2(_TilingAndOffset_4abf681168a949a1a05674de49c8d1c5_Out_3, (_Divide_39cf803ea6e04308a6246f49a4590249_Out_2.xx), _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0 = SAMPLE_TEXTURE2D(UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).tex, UnityBuildTexture2DStructNoScale(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1).samplerstate, _Add_041e1dfc654149dcaadc9b8b37d470c1_Out_2);
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.r;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.g;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.b;
            float _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_A_7 = _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2;
            Unity_Add_float(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_R_4, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_G_5, _Add_514c57978a5f46438b8b4f52fcd0117d_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2;
            Unity_Add_float(_Add_514c57978a5f46438b8b4f52fcd0117d_Out_2, _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_B_6, _Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_d1401406247141e18c986afd2ee6bcae_Out_2;
            Unity_Divide_float(_Add_7e3afaf13cbe42a588a466fe62a4cb3a_Out_2, 3, _Divide_d1401406247141e18c986afd2ee6bcae_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0 = Vector1_acc4d319559c4c12a59608a560b4772c;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2;
            Unity_Subtract_float(_Divide_d1401406247141e18c986afd2ee6bcae_Out_2, _Property_e1d10cbb59e04c0fa8f7e43c5ddbdb2b_Out_0, _Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1;
            float3x3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix = float3x3(IN.WorldSpaceTangent, IN.WorldSpaceBiTangent, IN.WorldSpaceNormal);
            float3 _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position = IN.WorldSpacePosition;
            Unity_NormalFromHeight_Tangent_float(_GradientNoise_5e6ebea06b524ee39e80a14476f4e893_Out_2,0.03,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Position,_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_TangentMatrix, _NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2;
            Unity_DotProduct_float3(_NormalFromHeight_be79571351ad4e7bae140629441ec3fe_Out_1, IN.WorldSpaceViewDirection, _DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2;
            Unity_Divide_float(_DotProduct_2ad5b26cb7cc463fa624a6aed195492f_Out_2, 8, _Divide_29eeea42a48640aabe125ecb62e01d06_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3;
            Unity_Clamp_float(_Divide_29eeea42a48640aabe125ecb62e01d06_Out_2, 0, 0.05, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Add_52df3467f68c48139c07c8c757cc127b_Out_2;
            Unity_Add_float(_Subtract_2cec8af51ff54e829bb94bce2dd78b94_Out_2, _Clamp_a82efbe23ce94b13b85c447e504faebc_Out_3, _Add_52df3467f68c48139c07c8c757cc127b_Out_2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Emission = (_Add_52df3467f68c48139c07c8c757cc127b_Out_2.xxx);
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TimeParameters =              _TimeParameters.xyz; // This is mainly for LW as HD overwrite this value
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"

            ENDHLSL
        }
        Pass
        {
            // Name: <None>
            Tags
            {
                "LightMode" = "Universal2D"
            }

            // Render State
            Cull Off
        Blend SrcAlpha OneMinusSrcAlpha, One OneMinusSrcAlpha
        ZTest LEqual
        ZWrite Off

            // Debug
            // <None>

            // --------------------------------------------------
            // Pass

            HLSLPROGRAM

            // Pragmas
            #pragma target 2.0
        #pragma only_renderers gles gles3 glcore d3d11
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag

            // DotsInstancingOptions: <None>
            // HybridV1InjectedBuiltinProperties: <None>

            // Keywords
            // PassKeywords: <None>
            #pragma shader_feature _ _RECEIVE_SHADOWS_OFF

        #if defined(_RECEIVE_SHADOWS_OFF)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif


            // Defines
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SURFACE_TYPE_TRANSPARENT 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _SPECULAR_SETUP
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_VIEWDIRECTION_WS
        #endif

            #define FEATURES_GRAPH_VERTEX
            /* WARNING: $splice Could not find named fragment 'PassInstancing' */
            #define SHADERPASS SHADERPASS_2D
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define REQUIRE_DEPTH_TEXTURE
        #endif
            /* WARNING: $splice Could not find named fragment 'DotsInstancingVars' */

            // Includes
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

            // --------------------------------------------------
            // Structs and Packing

            struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentOS : TANGENT;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 viewDirectionWS;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpaceViewDirection;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 WorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 ScreenPosition;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 interp2 : TEXCOORD2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 interp3 : TEXCOORD3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };

            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            output.positionCS = input.positionCS;
            output.interp0.xyz =  input.positionWS;
            output.interp1.xyz =  input.normalWS;
            output.interp2.xyzw =  input.tangentWS;
            output.interp3.xyz =  input.viewDirectionWS;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.positionWS = input.interp0.xyz;
            output.normalWS = input.interp1.xyz;
            output.tangentWS = input.interp2.xyzw;
            output.viewDirectionWS = input.interp3.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif

            // --------------------------------------------------
            // Graph

            // Graph Properties
            CBUFFER_START(UnityPerMaterial)
        float4 _SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1_TexelSize;
        float Vector1_8aaaa65e405749e29c4a471ce5c6ce3a;
        float Vector1_acc4d319559c4c12a59608a560b4772c;
        float Vector1_4053ff97c6de4755a984a3218d675292;
        float4 Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee_TexelSize;
        CBUFFER_END

        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        TEXTURE2D(_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        SAMPLER(sampler_SampleTexture2D_d7a94994b0ea484c9b565cdd684725c0_Texture_1);
        TEXTURE2D(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
        SAMPLER(samplerTexture2D_f2d9162fa6f5464cb86708d84fdaa5ee);

            // Graph Functions
            
        void Unity_SceneDepth_Eye_float(float4 UV, out float Out)
        {
            Out = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH(UV.xy), _ZBufferParams);
        }

        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }

        void Unity_Divide_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }

        void Unity_Subtract_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A - B;
        }

        void Unity_Projection_float3(float3 A, float3 B, out float3 Out)
        {
            Out = B * dot(A, B) / dot(B, B);
        }

        void Unity_Combine_float(float R, float G, float B, float A, out float4 RGBA, out float3 RGB, out float2 RG)
        {
            RGBA = float4(R, G, B, A);
            RGB = float3(R, G, B);
            RG = float2(R, G);
        }

        void Unity_Length_float3(float3 In, out float Out)
        {
            Out = length(In);
        }

        void Unity_Divide_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A / B;
        }

        void Unity_Multiply_float(float2 A, float2 B, out float2 Out)
        {
            Out = A * B;
        }

        void Unity_Add_float2(float2 A, float2 B, out float2 Out)
        {
            Out = A + B;
        }

        void Unity_Fraction_float2(float2 In, out float2 Out)
        {
            Out = frac(In);
        }

        void Unity_Step_float2(float2 Edge, float2 In, out float2 Out)
        {
            Out = step(Edge, In);
        }

        void Unity_Minimum_float2(float2 A, float2 B, out float2 Out)
        {
            Out = min(A, B);
        };

        void Unity_Minimum_float(float A, float B, out float Out)
        {
            Out = min(A, B);
        };

        struct Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0
        {
            float3 ObjectSpaceNormal;
            float3 ObjectSpaceTangent;
            float3 ObjectSpaceBiTangent;
            float3 WorldSpaceViewDirection;
            float4 ScreenPosition;
        };

        void SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 IN, out float3 WorldPosition_1, out float2 UV_2, out float Mask_3)
        {
            float _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1;
            Unity_SceneDepth_Eye_float(float4(IN.ScreenPosition.xy / IN.ScreenPosition.w, 0, 0), _SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1);
            float _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2;
            Unity_DotProduct_float3(IN.WorldSpaceViewDirection, -1 * mul((float3x3)UNITY_MATRIX_M, transpose(mul(UNITY_MATRIX_I_M, UNITY_MATRIX_I_V)) [2].xyz), _DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2);
            float3 _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2;
            Unity_Divide_float3(IN.WorldSpaceViewDirection, (_DotProduct_90c5e674e5bcec899775c7bb1bd9cb9c_Out_2.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2);
            float3 _Multiply_c21a291aa4786789aac51d4775638067_Out_2;
            Unity_Multiply_float((_SceneDepth_b5b8cab4d73a8182a311079266192ef3_Out_1.xxx), _Divide_acad63797f0d5d8386ea8460cec4a8cc_Out_2, _Multiply_c21a291aa4786789aac51d4775638067_Out_2);
            float3 _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            Unity_Add_float3(_Multiply_c21a291aa4786789aac51d4775638067_Out_2, _WorldSpaceCameraPos, _Add_156d8b921597978da515e85a41f1d37a_Out_2);
            float3 _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1 = TransformObjectToWorld(float3 (0, 0, 0).xyz);
            float3 _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2;
            Unity_Subtract_float3(_Add_156d8b921597978da515e85a41f1d37a_Out_2, _Transform_3ef1dd7dc3161a8b95b39c2cf34cc75a_Out_1, _Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2);
            float3 _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1 = TransformObjectToWorldDir(float3 (1, 0, 0).xyz);
            float3 _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2);
            float _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2;
            Unity_DotProduct_float3(_Projection_8ae2b7ef5d02038489ba6cecbb136461_Out_2, _Transform_4470da7b91499382ba8bb6bd80b4f0a9_Out_1, _DotProduct_77b9c811118f3888af11106d08578b1c_Out_2);
            float3 _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1 = TransformObjectToWorldDir(float3 (0, 0, 1).xyz);
            float3 _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2;
            Unity_Projection_float3(_Subtract_3c01059fb2c5e58e8aa89fc3432310e8_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2);
            float _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2;
            Unity_DotProduct_float3(_Projection_b6115230e3a9be86a74243e0cf3ff671_Out_2, _Transform_77cae52e3ad47785bba1cdabc1d04262_Out_1, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2);
            float4 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4;
            float3 _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5;
            float2 _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6;
            Unity_Combine_float(_DotProduct_77b9c811118f3888af11106d08578b1c_Out_2, _DotProduct_3a9b399cb1ebba88bbbab0029fee3d95_Out_2, 0, 0, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGBA_4, _Combine_3520c3eaea10c881a273d2c16dfe4631_RGB_5, _Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6);
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1 = UNITY_MATRIX_M[0];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2 = UNITY_MATRIX_M[1];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3 = UNITY_MATRIX_M[2];
            float4 _MatrixSplit_54e3e1842da51188999434dfa0f37678_M3_4 = UNITY_MATRIX_M[3];
            float _Split_373e7a713d260388ace24373655b8ce3_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[0];
            float _Split_373e7a713d260388ace24373655b8ce3_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[1];
            float _Split_373e7a713d260388ace24373655b8ce3_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[2];
            float _Split_373e7a713d260388ace24373655b8ce3_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M0_1[3];
            float _Split_1e59543853eb608ba386096601e2bb0b_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[0];
            float _Split_1e59543853eb608ba386096601e2bb0b_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[1];
            float _Split_1e59543853eb608ba386096601e2bb0b_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[2];
            float _Split_1e59543853eb608ba386096601e2bb0b_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M1_2[3];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[0];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_G_2 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[1];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[2];
            float _Split_5d81237b1e486f80a9e4c1c19988e4d5_A_4 = _MatrixSplit_54e3e1842da51188999434dfa0f37678_M2_3[3];
            float4 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4;
            float3 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5;
            float2 _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_R_1, _Split_1e59543853eb608ba386096601e2bb0b_R_1, _Split_5d81237b1e486f80a9e4c1c19988e4d5_R_1, 0, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGBA_4, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Combine_dfd55cb10b915e8a852f9c4034279d5a_RG_6);
            float _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1;
            Unity_Length_float3(_Combine_dfd55cb10b915e8a852f9c4034279d5a_RGB_5, _Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1);
            float4 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4;
            float3 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5;
            float2 _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6;
            Unity_Combine_float(_Split_373e7a713d260388ace24373655b8ce3_B_3, _Split_1e59543853eb608ba386096601e2bb0b_B_3, _Split_5d81237b1e486f80a9e4c1c19988e4d5_B_3, 0, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGBA_4, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RG_6);
            float _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1;
            Unity_Length_float3(_Combine_1eb66d14e0931e8f8b1ea7fa8846a1cd_RGB_5, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1);
            float4 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4;
            float3 _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5;
            float2 _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6;
            Unity_Combine_float(_Length_37cc7643ec10408a97d4e6f6acf0ea3b_Out_1, _Length_abf9f6edc4cf908f885351e676e3a8b7_Out_1, 0, 0, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGBA_4, _Combine_9f41318cb7630285a4b08f2fc218bf72_RGB_5, _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6);
            float2 _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2;
            Unity_Divide_float2(float2(1, 1), _Combine_9f41318cb7630285a4b08f2fc218bf72_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2);
            float2 _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2;
            Unity_Multiply_float(_Combine_3520c3eaea10c881a273d2c16dfe4631_RG_6, _Divide_c0ccb59a0e0db18dbb6a192007543205_Out_2, _Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2);
            float2 _Add_0bef7731dc2af18ba3f6419490e600df_Out_2;
            Unity_Add_float2(_Multiply_c8c4563acecc218a8612a1b2b30c1dce_Out_2, float2(0.5, 0.5), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2);
            float2 _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Unity_Fraction_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1);
            float2 _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2;
            Unity_Step_float2(float2(0, 0), _Add_0bef7731dc2af18ba3f6419490e600df_Out_2, _Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2);
            float2 _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2;
            Unity_Step_float2(_Add_0bef7731dc2af18ba3f6419490e600df_Out_2, float2(1, 1), _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2);
            float2 _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2;
            Unity_Minimum_float2(_Step_cc2cd72214fe0d82bca5b826f796b2b3_Out_2, _Step_753944fccdd8ef8aa30c49781bb05d54_Out_2, _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2);
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_R_1 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[0];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2 = _Minimum_600707943499b88a8a16eb74eecb59e8_Out_2[1];
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_B_3 = 0;
            float _Split_7e305fc424a80f8caca8d8cbdccdf844_A_4 = 0;
            float _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
            Unity_Minimum_float(_Split_7e305fc424a80f8caca8d8cbdccdf844_R_1, _Split_7e305fc424a80f8caca8d8cbdccdf844_G_2, _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2);
            WorldPosition_1 = _Add_156d8b921597978da515e85a41f1d37a_Out_2;
            UV_2 = _Fraction_1122aea98915778c9252392ea5f9b5ed_Out_1;
            Mask_3 = _Minimum_b3c49c1ee183f08599fe247f75ab7ffc_Out_2;
        }

        void Unity_Multiply_float(float A, float B, out float Out)
        {
            Out = A * B;
        }

            // Graph Vertex
            struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };

        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            description.Normal = IN.ObjectSpaceNormal;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }

            // Graph Pixel
            struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
        };

        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_DecalNode_e3588976b025b1440b9132c2f803d2a0 _DecalNode_83b6575382eb490f878e9a1fe6106d98;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceNormal = IN.ObjectSpaceNormal;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceTangent = IN.ObjectSpaceTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ObjectSpaceBiTangent = IN.ObjectSpaceBiTangent;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.WorldSpaceViewDirection = IN.WorldSpaceViewDirection;
            _DecalNode_83b6575382eb490f878e9a1fe6106d98.ScreenPosition = IN.ScreenPosition;
            float3 _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1;
            float2 _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2;
            float _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3;
            SG_DecalNode_e3588976b025b1440b9132c2f803d2a0(_DecalNode_83b6575382eb490f878e9a1fe6106d98, _DecalNode_83b6575382eb490f878e9a1fe6106d98_WorldPosition_1, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2, _DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_a4ef778142d94dec839559a9253d6b13_Out_0 = UnityBuildTexture2DStructNoScale(Texture2D_f2d9162fa6f5464cb86708d84fdaa5ee);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0 = SAMPLE_TEXTURE2D(_Property_a4ef778142d94dec839559a9253d6b13_Out_0.tex, _Property_a4ef778142d94dec839559a9253d6b13_Out_0.samplerstate, _DecalNode_83b6575382eb490f878e9a1fe6106d98_UV_2);
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_R_4 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.r;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_G_5 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.g;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_B_6 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.b;
            float _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7 = _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_RGBA_0.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            Unity_Multiply_float(_DecalNode_83b6575382eb490f878e9a1fe6106d98_Mask_3, _SampleTexture2D_33db434ad9f1485fae8665978bc835b2_A_7, _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2);
            #endif
            surface.BaseColor = IsGammaSpace() ? float3(0, 0, 0) : SRGBToLinear(float3(0, 0, 0));
            surface.Alpha = _Multiply_b8110938dca5450e8cc51695277ccfdb_Out_2;
            return surface;
        }

            // --------------------------------------------------
            // Build Graph Inputs

            VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           input.normalOS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          input.tangentOS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =         input.positionOS;
        #endif


            return output;
        }
            SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal =            renormFactor*input.normalWS.xyz;		// we want a unit length Normal Vector node in shader graph
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =           normalize(mul(output.WorldSpaceNormal, (float3x3) UNITY_MATRIX_M));           // transposed multiplication by inverse matrix to handle normal scale
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to preserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent =           renormFactor*input.tangentWS.xyz;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent =         renormFactor*bitang;
        #endif


        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =          TransformWorldToObjectDir(output.WorldSpaceTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceBiTangent =        TransformWorldToObjectDir(output.WorldSpaceBiTangent);
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceViewDirection =     input.viewDirectionWS; //TODO: by default normalized in HD, but not in universal
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpacePosition =          input.positionWS;
        #endif

        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ScreenPosition =              ComputeScreenPos(TransformWorldToHClip(input.positionWS), _ProjectionParams.x);
        #endif

        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN

            return output;
        }

            // --------------------------------------------------
            // Main

            #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"

            ENDHLSL
        }
    }
    CustomEditor "ShaderGraph.PBRMasterGUI"
    FallBack "Hidden/Shader Graph/FallbackError"
}