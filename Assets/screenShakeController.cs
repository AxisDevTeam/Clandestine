using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class screenShakeController : MonoBehaviour
{
    public Material mat;
    public float shakeIntensity = 0f;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        mat.SetFloat("_ShakeAmount", shakeIntensity);
    }
}
