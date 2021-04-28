void AdditionalLights_half(half3 WorldPosition, half3 WorldNormal, out half3 Diffuse)
{
	float3 Color = 0;
#ifndef SHADERGRAPH_PREVIEW
	int numLights = GetAdditionalLightsCount();
	for (int i = 0; i < numLights; i++)
	{
		Light light = GetAdditionalLight(i, WorldPosition);
		half3 AttLightColor = light.color * (light.distanceAttenuation * light.shadowAttenuation);
		Color += LightingLambert(AttLightColor, light.direction, WorldNormal);
	}
#endif
	Diffuse = Color;
}