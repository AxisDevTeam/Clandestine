using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class flashlightHandler : MonoBehaviour
{

    public float Battery = 100f;
    public bool LightIsOn = false;

    public float amountDecrease;
    public float amountIncrease;
    public bool recharging;
    
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

            if (recharging == false)
            {
                spot.SetActive(!spot.activeSelf);
                LightIsOn = spot.activeSelf;
            }
        }
        if (recharging == true)
        {
            spot.SetActive(false);
            LightIsOn = false;
        }
     
        if (LightIsOn == true)
        {
            Battery -= amountDecrease * Time.deltaTime;
        }
        else
        {
            Battery += amountIncrease * Time.deltaTime;
        }
        if (Battery <=0f)
        {
            recharging = true;
        }
        if (Battery >= 100f)
        {
            recharging = false;
        }

        Battery = Mathf.Clamp(Battery, 0f, 100f);   
    }

}
