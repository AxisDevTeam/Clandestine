using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HoldScript : MonoBehaviour
{
    // Start is called before the first frame update
    public Transform target;
    public float snappiness = 1f;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        RaycastHit hit;
        Debug.DrawRay(transform.position, transform.rotation.eulerAngles);
        if (Input.GetMouseButton(1))
        {
            if (Physics.Raycast(transform.position, transform.rotation.eulerAngles, out hit))
            {
                print(hit.transform.gameObject.name);
                if (hit.rigidbody)
                {
                    hit.rigidbody.AddForce((target.position - hit.transform.position) * snappiness);
                }
            }
        }
    }
}
