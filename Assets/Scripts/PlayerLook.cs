using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerLook : MonoBehaviour
{

    public float rotX;
    public float rotY;
    public float xVelocity;
    public float yVelocity;
    public float mouseSensitivity;
    public float snappiness;
    public float upDownRange;
    public Camera c;
    public Transform camstuff;
    public Transform player;
    //public ObjectHolding objectHolding;
    //public ObjectHolding oh;
    public bool doMouseMovement =true;

    // Start is called before the first frame update
    void Start()
    {
        Cursor.lockState = CursorLockMode.Locked;
    }

    // Update is called once per frame

    void Update()
    {
        Cursor.lockState = CursorLockMode.Locked;
        //rotX = Input.GetAxis("Mouse X") * mouseSensitivity;
        //rotY -= Input.GetAxis("Mouse Y") * mouseSensitivity;
        //control.Gameplay.MoveH.ReadValue<float>();


        rotX = Input.GetAxis("Mouse X") * mouseSensitivity;
        rotY -= Input.GetAxis("Mouse Y") * mouseSensitivity;
        
        xVelocity = Mathf.Lerp(xVelocity, rotX, snappiness * Time.deltaTime);
        yVelocity = Mathf.Lerp(yVelocity, rotY, snappiness * Time.deltaTime);
        
        

        //Debug.Log(rotX + " , " + rotY);
        //Debug.Log(control.Gameplay.Jump.ReadValue<float>());

        if (doMouseMovement == true)
        {
            //RotY
            rotY = Mathf.Clamp(rotY, -upDownRange, upDownRange);
            camstuff.transform.localRotation = Quaternion.Euler(yVelocity, 0, 0);

            //RotX
            player.Rotate(0, xVelocity, 0);
        }

        /*
        if (Input.GetKeyDown("l"))
        {
            if (Cursor.lockState == CursorLockMode.Locked)
            {
                Cursor.lockState = CursorLockMode.Confined;
            }
            else
            {
                Cursor.lockState = CursorLockMode.Locked;
            }
        } 
        */
    }
}
