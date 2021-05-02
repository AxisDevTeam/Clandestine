using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class flashlightHandler : MonoBehaviour
{
    public GameObject spot;
    public GameObject flashlight;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown("f"))
        {
            spot.SetActive(!spot.activeSelf); 
        }
    }
}
