using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class renderQueueFixer : MonoBehaviour
{
    // Start is called before the first frame update
    public Material smokeParticle;
    void Start()
    {
        smokeParticle.renderQueue = 2000;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
