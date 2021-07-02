using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class viewSway : MonoBehaviour
{
    // Start is called before the first frame update
    public Vector3 baseRot;
    public float Xmult = 1f;
    public float Ymult = 1f;
    public float rotX;
    public float rotY;
    public float xVelocity;
    public float yVelocity;
    public float snappiness;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        rotX = -Input.GetAxis("Mouse X") * Xmult;
        rotY = Input.GetAxis("Mouse Y") * Ymult;

        xVelocity = Mathf.Lerp(xVelocity, rotX, snappiness * Time.deltaTime);
        yVelocity = Mathf.Lerp(yVelocity, rotY, snappiness * Time.deltaTime);

        transform.localRotation = Quaternion.Euler(new Vector3(baseRot.x + yVelocity,baseRot.y+xVelocity,baseRot.z));
    }
}
