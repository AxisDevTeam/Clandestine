using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class limitFPS : MonoBehaviour
{
    public Camera overCam;
    public float fps = 30;
    // Start is called before the first frame update
    void Start()
    {
        StartCoroutine(DelayedRendering());
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    public IEnumerator DelayedRendering()
    {
        while (true)
        {
            overCam.enabled = !overCam.enabled;
            yield return new WaitForSeconds(1/fps);
        }
    }
}
